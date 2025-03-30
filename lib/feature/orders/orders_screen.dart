import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:thara_coffee/feature/orders/widgets/payment_success_screen.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/primary_button.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final payNowController = MultiStateButtonController();

  @override
  void dispose() {
    payNowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: CustomScrollView(
                slivers: <Widget>[
                  // SliverAppBar(
                  //   backgroundColor: Colors.transparent,
                  //   leadingWidth: KPadding.h80,
                  //   leading: Container(
                  //     padding: EdgeInsets.all(KRadius.r17),
                  //     margin: EdgeInsets.only(left: KPadding.h16),
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle, color: ColorManager.lightGrey2),
                  //     child: SvgPicture.asset(SvgAssets.location),
                  //   ),
                  //   actions: [
                  //     Container(
                  //       padding: EdgeInsets.all(KRadius.r18),
                  //       margin: EdgeInsets.only(right: KPadding.h16),
                  //       decoration: BoxDecoration(
                  //           shape: BoxShape.circle, color: ColorManager.lightGrey2),
                  //       child: SvgPicture.asset(SvgAssets.hamburger),
                  //     )
                  //   ],
                  //   // pinned: true,
                  //   centerTitle: false,
                  //   pinned: true,
                  //   floating: true,
                  // ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Text(
                            'Order Summary',
                            style: textTheme(context)
                                .headlineMedium
                                ?.copyWith(fontSize: KFontSize.f20),
                          ),
                          16.verticalSpace,
                          Container(
                            padding: EdgeInsets.only(
                                right: 13.w,
                                top: 24.h,
                                left: 17.w,
                                bottom: 16.h),
                            decoration: BoxDecoration(
                              color: ColorManager.whiteColor,
                              border: Border.all(color: ColorManager.eee),
                              borderRadius: BorderRadius.circular(KRadius.r15),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cappuccino',
                                          style: textTheme(context)
                                              .displayMedium
                                              ?.copyWith(
                                                  fontSize: KFontSize.f14,
                                                  color:
                                                      ColorManager.secondary),
                                        ),
                                        Text(
                                          'with chocolate',
                                          style: textTheme(context)
                                              .displaySmall
                                              ?.copyWith(
                                                  fontSize: KFontSize.f12,
                                                  color:
                                                      ColorManager.grey8D8D8D),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(KRadius.r10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorManager.eee),
                                          child: Icon(Icons.remove),
                                        ),
                                        6.horizontalSpace,
                                        Container(
                                          padding: EdgeInsets.all(KRadius.r15),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorManager.errorColor),
                                          child: Text(
                                            '3',
                                            style: textTheme(context)
                                                .headlineLarge
                                                ?.copyWith(
                                                    fontSize: KFontSize.f20),
                                          ),
                                        ),
                                        7.horizontalSpace,
                                        Container(
                                          padding: EdgeInsets.all(KRadius.r10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorManager.grey4F4F4F),
                                          child: Icon(
                                            Icons.add,
                                            color: ColorManager.whiteColor,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                13.verticalSpace,
                                Divider(
                                  color: ColorManager.f1f1f1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '₹ 298.00',
                                      style: textTheme(context)
                                          .titleMedium
                                          ?.copyWith(fontSize: KFontSize.f18),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          25.verticalSpace,
                          Text(
                            'Order Summary',
                            style: textTheme(context)
                                .headlineMedium
                                ?.copyWith(fontSize: KFontSize.f20),
                          ),
                          10.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.whiteColor,
                              borderRadius: BorderRadius.circular(KRadius.r15),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 20.w,
                                      top: 16.h,
                                      left: 11.w,
                                      bottom: 12.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Selected',
                                        style: textTheme(context)
                                            .titleSmall
                                            ?.copyWith(
                                              fontSize: KFontSize.f13,
                                            ),
                                      ),
                                      Text(
                                        '4',
                                        style: textTheme(context)
                                            .headlineMedium
                                            ?.copyWith(
                                              fontSize: KFontSize.f14,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                ColoredBox(
                                  color: ColorManager.f9f9f9,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 20.w,
                                        top: 16.h,
                                        left: 11.w,
                                        bottom: 12.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sub total',
                                          style: textTheme(context)
                                              .titleSmall
                                              ?.copyWith(
                                                fontSize: KFontSize.f13,
                                              ),
                                        ),
                                        Text(
                                          '₹ 298.00',
                                          style: textTheme(context)
                                              .headlineMedium
                                              ?.copyWith(
                                                fontSize: KFontSize.f14,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(KRadius.r15),
                                    bottomRight: Radius.circular(KRadius.r15),
                                  ),
                                  child: ColoredBox(
                                    color: ColorManager.fc545b,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 20.w,
                                          top: 16.h,
                                          left: 11.w,
                                          bottom: 12.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Payable Amount',
                                            style: textTheme(context)
                                                .titleSmall
                                                ?.copyWith(
                                                  fontSize: KFontSize.f13,
                                                ),
                                          ),
                                          Text(
                                            '₹ 298.00',
                                            style: textTheme(context)
                                                .displayMedium
                                                ?.copyWith(
                                                  fontSize: KFontSize.f14,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          250.verticalSpace,
                          PrimaryButton(
                              key: Key('pay'),
                              width: double.infinity,
                              controller: payNowController,
                              color: ColorManager.primary,
                              borderRadius: KRadius.r100,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentSuccessScreen()));
                              },
                              text: 'Pay now'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
