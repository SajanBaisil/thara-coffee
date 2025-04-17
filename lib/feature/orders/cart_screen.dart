import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thara_coffee/feature/login/domain/model/login_response.dart';
import 'package:thara_coffee/feature/orders/orders_bloc/orders_bloc.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/common_shimmer.dart';
import 'package:thara_coffee/shared/components/datafetch_status.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/local_storage/keys.dart';
import 'package:thara_coffee/shared/local_storage/local_storage_service.dart';
import 'package:thara_coffee/shared/router/http%20utils/http_helper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    fetchPosOrder();
  }

  fetchPosOrder() async {
    final userData = await serviceLocator<LocalStorageService>()
        .getFromLocal(LocalStorageKeys.loginResponse);
    log('userData  ---- $userData');
    final loginResponse = LoginResponse.fromJson(jsonDecode(userData ?? ""));
    context
        .read<OrdersBloc>()
        .add(GetPosOrderEvent(mobile: loginResponse.mobile ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersBloc, OrdersState>(
      listenWhen: (previous, current) =>
          previous.getPosOrderFetchStatus != current.getPosOrderFetchStatus,
      buildWhen: (previous, current) =>
          previous.getPosOrderFetchStatus != current.getPosOrderFetchStatus,
      listener: (context, state) {
        if (state.getPosOrderFetchStatus == DataFetchStatus.failed) {
          HttpHelper.handleMessage(state.errorMessage, context,
              type: HandleTypes.snackbar);
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: ColorManager.whiteColor,
            body: Stack(
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: MediaQuery.removeViewInsets(
                          context: context,
                          removeBottom: true,
                          child: Image.asset(
                            ImageAssets.largeBg,
                            color: ColorManager.fdf1f1,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: CustomScrollView(slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          'Your Orders',
                          style: textTheme(context)
                              .headlineMedium
                              ?.copyWith(fontSize: KFontSize.f20),
                        ),
                      ),

                      // SliverList(
                      //   delegate: SliverChildListDelegate([

                      //     OrderWidget(
                      //       title: 'Cappuccino',
                      //       subTitle: 'with chocolate',
                      //       color: ColorManager.greenColorWithAlpha,
                      //       borderColor: ColorManager.greenColor,
                      //     ),
                      //     21.verticalSpace,
                      //     OrderWidget(
                      //       title: 'Cappuccino',
                      //       subTitle: 'with chocolate',
                      //       color: ColorManager.orangeColorWithAlpha,
                      //       borderColor: ColorManager.orangeColor,
                      //     ),
                      //     21.verticalSpace,
                      //     OrderWidget(
                      //       title: 'Cappuccino',
                      //       subTitle: 'without sugar',
                      //       color: ColorManager.redColorWithAlpha,
                      //       borderColor: ColorManager.primary,
                      //     ),
                      //   ]),
                      // ),
                    ),
                    SliverToBoxAdapter(
                      child: 16.verticalSpace,
                    ),
                    state.getPosOrderFetchStatus == DataFetchStatus.waiting
                        ? SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 17.w),
                            sliver: SliverList.separated(
                              itemCount: 5,
                              separatorBuilder: (context, index) =>
                                  5.verticalSpace,
                              itemBuilder: (context, index) =>
                                  OrderWidgetShimmer(),
                            ),
                          )
                        : state.posOrders?.data?.isEmpty ?? false
                            ? SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 250.h),
                                  child: Center(
                                    child: Text(
                                      'No Orders Found',
                                      style: textTheme(context)
                                          .titleSmall
                                          ?.copyWith(fontSize: KFontSize.f16),
                                    ),
                                  ),
                                ),
                              )
                            : SliverPadding(
                                padding: EdgeInsets.only(
                                    left: 17.w, right: 17.w, bottom: 10.h),
                                sliver: SliverList.separated(
                                  separatorBuilder: (context, index) =>
                                      5.verticalSpace,
                                  itemCount: state.posOrders?.allLines.length,
                                  itemBuilder: (context, index) => OrderWidget(
                                    amount: state.posOrders?.allLines[index]
                                            .subtotal ??
                                        "",
                                    cookingStatus: 'Ready',
                                    // state.posOrders?.data?[index].state ??
                                    // "",
                                    productQty:
                                        state.posOrders?.allLines[index].qty ??
                                            "",
                                    title: state.posOrders?.allLines[index]
                                            .product ??
                                        "",
                                    subTitle: state.posOrders?.allLines[index]
                                            .customerNote ??
                                        "",
                                    color: ColorManager.redColorWithAlpha,
                                    borderColor: ColorManager.primary,
                                  ),
                                ),
                              ),
                  ]),
                ),
              ],
            ));
      },
    );
  }
}

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.color,
    required this.borderColor,
    required this.productQty,
    required this.cookingStatus,
    required this.amount,
  });

  final String title;
  final String subTitle;
  final Color color;
  final Color borderColor;
  final String productQty;
  final String cookingStatus;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(right: 13.w, top: 24.h, left: 17.w, bottom: 16.h),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        border: Border.all(color: ColorManager.eee),
        borderRadius: BorderRadius.circular(KRadius.r15),
        boxShadow: [
          BoxShadow(
            color: ColorManager.secondary.withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: ColorManager.secondary.withOpacity(0.04),
            offset: const Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme(context).displayMedium?.copyWith(
                        fontSize: KFontSize.f14, color: ColorManager.secondary),
                  ),
                  Text(
                    subTitle,
                    style: textTheme(context).displaySmall?.copyWith(
                        fontSize: KFontSize.f12,
                        color: ColorManager.grey8D8D8D),
                  ),
                ],
              ),
              Row(
                children: [
                  // Container(
                  //   padding: EdgeInsets.all(KRadius.r10),
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle, color: ColorManager.eee),
                  //   child: Icon(Icons.remove),
                  // ),
                  // 6.horizontalSpace,
                  Text('Quantity :',
                      style: textTheme(context)
                          .titleSmall
                          ?.copyWith(fontSize: KFontSize.f12)),
                  6.horizontalSpace,
                  Text(
                    productQty.split('.').first,
                    style: textTheme(context).titleSmall?.copyWith(
                        fontSize: KFontSize.f16, color: ColorManager.primary),
                  ),
                  // 7.horizontalSpace,
                  // Container(
                  //   padding: EdgeInsets.all(KRadius.r10),
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle, color: ColorManager.grey4F4F4F),
                  //   child: Icon(
                  //     Icons.add,
                  //     color: ColorManager.whiteColor,
                  //   ),
                  // )
                ],
              )
            ],
          ),
          13.verticalSpace,
          Divider(
            color: ColorManager.f1f1f1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Cooking Status',
                    style: textTheme(context).displaySmall?.copyWith(
                        fontSize: KFontSize.f12,
                        color: ColorManager.grey8D8D8D),
                  ),
                  7.horizontalSpace,
                  Container(
                      padding: EdgeInsets.only(
                          left: 12.w, top: 4.h, right: 7.w, bottom: 4.h),
                      decoration: BoxDecoration(
                          color: color,
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(KRadius.r5)),
                      child: Text(cookingStatus))
                ],
              ),
              Text(
                '₹$amount',
                style: textTheme(context)
                    .titleMedium
                    ?.copyWith(fontSize: KFontSize.f18),
              )
            ],
          )
        ],
      ),
    );
  }
}

class OrderWidgetShimmer extends StatelessWidget {
  const OrderWidgetShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(right: 13.w, top: 24.h, left: 17.w, bottom: 16.h),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        border: Border.all(color: ColorManager.eee),
        borderRadius: BorderRadius.circular(KRadius.r15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonShimmer(
                    child: Text(
                      'Cappuccino',
                      style: textTheme(context).displayMedium?.copyWith(
                          fontSize: KFontSize.f14,
                          color: ColorManager.secondary),
                    ),
                  ),
                  CommonShimmer(
                    child: Text(
                      'with chocolate',
                      style: textTheme(context).displaySmall?.copyWith(
                          fontSize: KFontSize.f12,
                          color: ColorManager.grey8D8D8D),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Container(
                  //   padding: EdgeInsets.all(KRadius.r10),
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle, color: ColorManager.eee),
                  //   child: Icon(Icons.remove),
                  // ),
                  // 6.horizontalSpace,
                  CommonShimmer(
                    child: Text('Quantity :',
                        style: textTheme(context)
                            .titleSmall
                            ?.copyWith(fontSize: KFontSize.f12)),
                  ),
                  6.horizontalSpace,
                  CommonShimmer(
                    child: Text(
                      '3',
                      style: textTheme(context).titleSmall?.copyWith(
                          fontSize: KFontSize.f16, color: ColorManager.primary),
                    ),
                  ),
                  // 7.horizontalSpace,
                  // Container(
                  //   padding: EdgeInsets.all(KRadius.r10),
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle, color: ColorManager.grey4F4F4F),
                  //   child: Icon(
                  //     Icons.add,
                  //     color: ColorManager.whiteColor,
                  //   ),
                  // )
                ],
              )
            ],
          ),
          13.verticalSpace,
          Divider(
            color: ColorManager.f1f1f1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CommonShimmer(
                    child: Text(
                      'Cooking Status',
                      style: textTheme(context).displaySmall?.copyWith(
                          fontSize: KFontSize.f12,
                          color: ColorManager.grey8D8D8D),
                    ),
                  ),
                  7.horizontalSpace,
                  Container(
                      padding: EdgeInsets.only(
                          left: 12.w, top: 4.h, right: 7.w, bottom: 4.h),
                      decoration: BoxDecoration(
                          color: ColorManager.greenColorWithAlpha,
                          border: Border.all(color: ColorManager.greenColor),
                          borderRadius: BorderRadius.circular(KRadius.r5)),
                      child: CommonShimmer(child: Text('Ready')))
                ],
              ),
              CommonShimmer(
                child: Text(
                  '₹280',
                  style: textTheme(context)
                      .titleMedium
                      ?.copyWith(fontSize: KFontSize.f18),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
