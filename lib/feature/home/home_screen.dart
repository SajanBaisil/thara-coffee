import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thara_coffee/feature/home/coffee_detail_section.dart';
import 'package:thara_coffee/feature/home/domain/model/product_model.dart';
import 'package:thara_coffee/feature/home/logic/home_bloc/home_bloc.dart';
import 'package:thara_coffee/feature/home/logic/home_bloc/home_event.dart';
import 'package:thara_coffee/feature/home/logic/home_bloc/home_state.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/common_shimmer.dart';
import 'package:thara_coffee/shared/components/datafetch_status.dart';
import 'package:thara_coffee/shared/components/labeled_textfield.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/domain/helpers/snack_bar.dart';
import 'package:thara_coffee/shared/extensions/on_string.dart';
import 'package:thara_coffee/shared/router/http%20utils/http_helper.dart';
import 'package:thara_coffee/shared/router/responsive_helper.dart' as res;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<HomeBloc>().add(CategoryFetchEvent());
    // });

    // searchController.addListener(() {
    //   context
    //       .read<HomeBloc>()
    //       .add(SearchProductsEvent(searchController.text.trim()));
    // });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = serviceLocator<res.ResponsiveHelper>().isSmallScreen;
    final isLargeScreen = serviceLocator<res.ResponsiveHelper>().isLargeScreen;
    final isTallScreen = serviceLocator<res.ResponsiveHelper>().isTallScreen;
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.categoryFetchStatus != current.categoryFetchStatus,
      listener: (context, state) {
        if (state.categoryFetchStatus == DataFetchStatus.success) {
          context
              .read<HomeBloc>()
              .add(CategorySelectedEvent(state.categoryData?.first.id ?? ""));
        }
        if (state.categoryFetchStatus == DataFetchStatus.failed) {
          HttpHelper.handleMessage(state.errorMessage, context,
              type: HandleTypes.snackbar, snackBarType: SnackBarType.error);
        }
      },
      builder: (context, state) {
        return BlocConsumer<HomeBloc, HomeState>(
          listenWhen: (previous, current) =>
              previous.productFetchStatus != current.productFetchStatus,
          listener: (context, state) {
            if (state.productFetchStatus == DataFetchStatus.failed) {
              HttpHelper.handleMessage(state.errorMessage, context,
                  type: HandleTypes.snackbar, snackBarType: SnackBarType.error);
            }
          },
          builder: (context, product) {
            return Scaffold(
              backgroundColor: ColorManager.whiteColor,
              resizeToAvoidBottomInset:
                  false, // Prevent resizing when keyboard opens
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
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        leadingWidth: isSmallScreen
                            ? 75.h
                            : isLargeScreen
                                ? 100.h
                                : KPadding.h80,
                        leading: Container(
                          padding: EdgeInsets.all(KRadius.r17),
                          margin: EdgeInsets.only(left: KPadding.h16),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorManager.lightGrey2),
                          child: SvgPicture.asset(SvgAssets.location),
                        ),
                        actions: [
                          Container(
                            padding: EdgeInsets.all(isSmallScreen
                                ? 9.r
                                : isLargeScreen
                                    ? 14.r
                                    : KRadius.r18),
                            margin: EdgeInsets.only(right: KPadding.h16),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorManager.lightGrey2),
                            child: SvgPicture.asset(SvgAssets.hamburger),
                          )
                        ],
                        expandedHeight:
                            isSmallScreen ? KHeight.h150 : KHeight.h130,
                        // pinned: true,
                        centerTitle: false,
                        pinned: true,
                        floating: true,
                        flexibleSpace: FlexibleSpaceBar(
                            background: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: KPadding.h16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LabeledTextField(
                                hintText: 'Search “Coffee”',
                                borderRadius: KRadius.r100,
                                fillColor: ColorManager.whiteColor,
                                controller: searchController,
                                borderColor: ColorManager.grey,
                                onChanged: (value) {
                                  context
                                      .read<HomeBloc>()
                                      .add(SearchProductsEvent(value));
                                },
                                suffix: Container(
                                  margin: EdgeInsets.all(KRadius.r5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: ColorManager.grey)),
                                  padding: EdgeInsets.all(KPadding.h8),
                                  child: Icon(
                                    Icons.search,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Image.asset(
                                  alignment: Alignment.topCenter,
                                  ImageAssets.tharaCoffeeTruck),
                            ),
                            ASpecialCoffeeWidget(),
                            20.verticalSpace,
                            state.categoryFetchStatus == DataFetchStatus.waiting
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: KPadding.h16),
                                    child: SizedBox(
                                      height: isSmallScreen
                                          ? KHeight.h80
                                          : isLargeScreen
                                              ? KHeight.h80
                                              : KHeight.h80,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (_, __) =>
                                            SizedBox(width: KWidth.w10),
                                        itemCount: 5,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return CommonShimmer(
                                            child: CoffeeItemWidget(
                                              onTap: () {},
                                              title: 'Iced',
                                              borderColor: ColorManager.f1f1f1,
                                              icon: '',
                                              textColor:
                                                  ColorManager.greyTextColor,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: KPadding.h16),
                                    child: SizedBox(
                                      height: isSmallScreen
                                          ? KHeight.h90
                                          : isLargeScreen
                                              ? KHeight.h90
                                              : KHeight.h90,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (_, __) =>
                                            SizedBox(width: KWidth.w10),
                                        itemCount:
                                            state.categoryData?.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return CoffeeItemWidget(
                                            onTap: () {
                                              context
                                                  .read<HomeBloc>()
                                                  .add(CategorySelectedEvent(
                                                    state.categoryData?[index]
                                                            .id ??
                                                        '',
                                                  ));
                                            },
                                            title: state.categoryData?[index]
                                                    .name ??
                                                '',
                                            borderColor:
                                                state.selectedCategoryIndex ==
                                                        state
                                                            .categoryData?[
                                                                index]
                                                            .id
                                                    ? ColorManager.f1a01d
                                                    : ColorManager.f1f1f1,
                                            icon: state.categoryData?[index]
                                                    .image ??
                                                '',
                                            textColor:
                                                state.selectedCategoryIndex ==
                                                        state
                                                            .categoryData?[
                                                                index]
                                                            .id
                                                    ? ColorManager.f1a01d
                                                    : ColorManager
                                                        .greyTextColor,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                            15.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: KPadding.h16),
                              child: Row(
                                children: [
                                  Text(
                                    'Special Offer',
                                    style: textTheme(context)
                                        .titleMedium
                                        ?.copyWith(fontSize: KFontSize.f16),
                                  ),
                                ],
                              ),
                            ),
                            10.verticalSpace,
                          ],
                        ),
                      ),
                      product.productFetchStatus == DataFetchStatus.waiting
                          ? SliverPadding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: KPadding.h16),
                              sliver: SliverGrid.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: isLargeScreen ? 3 : 2,
                                  crossAxisSpacing: KWidth.w10,
                                  mainAxisSpacing: KHeight.h10,
                                  mainAxisExtent: isSmallScreen
                                      ? 295.h
                                      : isLargeScreen
                                          ? 200.h
                                          : (isTallScreen && !isLargeScreen)
                                              ? 258.h
                                              : KHeight.h250,
                                ),
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return CoffeeListItemWidgetShimmer(
                                    onTap: () {},
                                  );
                                },
                              ),
                            )
                          : product.productFetchStatus ==
                                      DataFetchStatus.success &&
                                  (product.filteredProducts?.isEmpty ?? false)
                              ? SliverToBoxAdapter(
                                  child: Text('No products found'),
                                )
                              : SliverPadding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: KPadding.h16),
                                  sliver: SliverGrid.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: isLargeScreen ? 3 : 2,
                                      crossAxisSpacing: KWidth.w10,
                                      mainAxisSpacing: KHeight.h10,
                                      mainAxisExtent: isSmallScreen
                                          ? 295.h
                                          : isLargeScreen
                                              ? 200.h
                                              : (isTallScreen && !isLargeScreen)
                                                  ? 258.h
                                                  : KHeight.h250,
                                    ),
                                    itemCount:
                                        product.filteredProducts?.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CoffeeListItemWidget(
                                        product:
                                            product.filteredProducts?[index],
                                        onTap: () {
                                          Navigator.of(context).push(
                                              _createRoute(
                                                  product:
                                                      product.filteredProducts?[
                                                          index]));
                                        },
                                      );
                                    },
                                  ),
                                )
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Route _createRoute({required ProductModel? product}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          CoffeeDetailSection(
        product: product,
      ),
      opaque: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        );
      },
    );
  }
}

class CoffeeListItemWidget extends StatelessWidget {
  const CoffeeListItemWidget(
      {super.key, required this.onTap, required this.product});
  final Function()? onTap;
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = serviceLocator<res.ResponsiveHelper>().isSmallScreen;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: KPadding.h5, vertical: KPadding.v10),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.lightGrey2),
          borderRadius: BorderRadius.circular(KRadius.r10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(KRadius.r10),
                  child: _buildImage(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: KPadding.h6, vertical: KPadding.v2),
                      margin: EdgeInsets.symmetric(
                          vertical: KPadding.v10, horizontal: KPadding.h10),
                      decoration: BoxDecoration(
                          color: ColorManager.fff6c0,
                          borderRadius: BorderRadius.circular(KRadius.r100)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(SvgAssets.star),
                          Text('4.8'),
                          5.horizontalSpace,
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            10.verticalSpace,
            Flexible(
              child: Text(
                product?.name ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: textTheme(context)
                    .headlineMedium
                    ?.copyWith(fontSize: KFontSize.f14),
              ),
            ),
            // Text(
            //   'with chocolate',
            //   style: textTheme(context).labelMedium?.copyWith(
            //       fontSize: KFontSize.f11, color: ColorManager.grey8F8F8F),
            // ),
            5.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹ ${product?.price}',
                  style: textTheme(context)
                      .titleMedium
                      ?.copyWith(fontSize: KFontSize.f14),
                ),
                Container(
                  padding: EdgeInsets.all(KRadius.r6),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: ColorManager.errorColor),
                  child: Icon(
                    Icons.add,
                    color: ColorManager.whiteColor,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    try {
      if (product?.image.isNullOrEmpty ?? false) {
        return Image.asset(
          ImageAssets.coffee,
          width: double.infinity,
          height: 160.h,
        );
      }

      final String cleanBase64 =
          product?.image?.replaceAll(RegExp(r'data:image/\w+;base64,'), '') ??
              "";
      final decodedImage = base64Decode(cleanBase64);

      return Image.memory(
        decodedImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 160.h,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.coffee, color: ColorManager.grey);
        },
      );
    } catch (e) {
      return Image.asset(
        ImageAssets.coffee,
        width: double.infinity,
        height: 160.h,
      );
    }
  }
}

class CoffeeListItemWidgetShimmer extends StatelessWidget {
  const CoffeeListItemWidgetShimmer({super.key, required this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = serviceLocator<res.ResponsiveHelper>().isSmallScreen;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: KPadding.h5, vertical: KPadding.v10),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.lightGrey2),
          borderRadius: BorderRadius.circular(KRadius.r10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(KRadius.r10),
                  child: CommonShimmer(child: Image.asset(ImageAssets.coffee)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: KPadding.h6, vertical: KPadding.v2),
                      margin: EdgeInsets.symmetric(
                          vertical: KPadding.v10, horizontal: KPadding.h10),
                      decoration: BoxDecoration(
                          color: ColorManager.fff6c0,
                          borderRadius: BorderRadius.circular(KRadius.r100)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(SvgAssets.star),
                          CommonShimmer(child: Text('4.8')),
                          5.horizontalSpace,
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            8.verticalSpace,
            CommonShimmer(
              child: Text(
                'Cappuccino',
                style: textTheme(context)
                    .headlineMedium
                    ?.copyWith(fontSize: KFontSize.f14),
              ),
            ),
            CommonShimmer(
              child: Text(
                'with chocolate',
                style: textTheme(context).labelMedium?.copyWith(
                    fontSize: KFontSize.f11, color: ColorManager.grey8F8F8F),
              ),
            ),
            5.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonShimmer(
                  child: Text(
                    '₹ 149.00',
                    style: textTheme(context)
                        .titleMedium
                        ?.copyWith(fontSize: KFontSize.f14),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(KRadius.r6),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: ColorManager.errorColor),
                  child: CommonShimmer(
                    child: Icon(
                      Icons.add,
                      color: ColorManager.whiteColor,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CoffeeItemWidget extends StatelessWidget {
  const CoffeeItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.borderColor,
    required this.textColor,
    required this.onTap,
  });
  final String title;
  final String icon;
  final Color borderColor;
  final Color? textColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: KHeight.h50,
            width: KWidth.w50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.f1f1f1,
                border: Border.all(color: borderColor)),
            child: ClipOval(child: _buildImage()),
          ),
          5.verticalSpace,
          SizedBox(
            width: KWidth.w70,
            child: Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: textTheme(context).labelMedium?.copyWith(color: textColor),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage() {
    try {
      if (icon.isEmpty) {
        return Icon(Icons.coffee, color: ColorManager.grey);
      }

      final String cleanBase64 =
          icon.replaceAll(RegExp(r'data:image/\w+;base64,'), '');
      final decodedImage = base64Decode(cleanBase64);

      return Image.memory(
        decodedImage,
        fit: BoxFit.cover,
        width: KWidth.w50,
        height: KHeight.h50,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.coffee, color: ColorManager.grey);
        },
      );
    } catch (e) {
      return Icon(Icons.coffee, color: ColorManager.grey);
    }
  }
}

class ASpecialCoffeeWidget extends StatelessWidget {
  const ASpecialCoffeeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: KPadding.h16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: KWidth.w2,
                  color: ColorManager.secondary,
                ),
                14.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'A ',
                            style: textTheme(context).titleLarge?.copyWith(
                                fontSize: KFontSize.f35,
                                fontWeight: FontWeight.bold,
                                color: ColorManager
                                    .secondary), // Set the text color to white
                          ),
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                ColorManager.primary,
                                ColorManager.f1a01d
                              ], // Replace with your desired colors
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: Text(
                              'Special Coffee',
                              style: textTheme(context).titleLarge?.copyWith(
                                  fontSize: KFontSize.f35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .white), // Set the text color to white
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Prepared for you',
                        style: textTheme(context).titleLarge?.copyWith(
                            fontSize: KFontSize.f35,
                            fontWeight: FontWeight.bold,
                            color: ColorManager
                                .secondary), // Set the text color to white
                      ),
                      7.verticalSpace,
                      Text(
                        'The Coffee Caravan brings the delightful aroma of freshly brewed coffee to unexpected locations.',
                        style: textTheme(context).titleSmall?.copyWith(
                            fontSize: KFontSize.f12, color: ColorManager.grey2),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
