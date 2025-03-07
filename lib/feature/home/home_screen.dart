import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/labeled_textfield.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      resizeToAvoidBottomInset: false, // Prevent resizing when keyboard opens
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
                      color: Colors.amber,
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
                leadingWidth: KPadding.h80,
                leading: Container(
                  padding: EdgeInsets.all(KRadius.r17),
                  margin: EdgeInsets.only(left: KPadding.h16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: ColorManager.lightGrey2),
                  child: SvgPicture.asset(SvgAssets.location),
                ),
                actions: [
                  Container(
                    padding: EdgeInsets.all(KRadius.r18),
                    margin: EdgeInsets.only(right: KPadding.h16),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: ColorManager.lightGrey2),
                    child: SvgPicture.asset(SvgAssets.hamburger),
                  )
                ],
                expandedHeight: KHeight.h130,
                // pinned: true,
                centerTitle: false,
                pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                  padding: EdgeInsets.symmetric(horizontal: KPadding.h16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LabeledTextField(
                        hintText: 'Search “Coffee”',
                        borderRadius: KRadius.r100,
                        fillColor: ColorManager.whiteColor,
                        controller: searchController,
                        borderColor: ColorManager.grey,
                        suffix: Container(
                          margin: EdgeInsets.all(KRadius.r5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: ColorManager.grey)),
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: KPadding.h16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CoffeeItemWidget(
                            title: 'Iced',
                            color: ColorManager.f1f1f1,
                            icon: SvgAssets.icedTea,
                          ),
                          CoffeeItemWidget(
                            title: 'Mocha',
                            color: ColorManager.f1f1f1,
                            icon: SvgAssets.mocha,
                          ),
                          CoffeeItemWidget(
                            title: 'Cappuccino',
                            color: ColorManager.f1a01d,
                            icon: SvgAssets.cappuccino,
                          ),
                          CoffeeItemWidget(
                            title: 'Espresso',
                            color: ColorManager.f1f1f1,
                            icon: SvgAssets.expresso,
                          ),
                          CoffeeItemWidget(
                            title: 'Doppio',
                            color: ColorManager.f1f1f1,
                            icon: SvgAssets.doppio,
                          ),
                        ],
                      ),
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: KPadding.h16),
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
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CoffeeItemWidget extends StatelessWidget {
  const CoffeeItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });
  final String title;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: KHeight.h50,
          width: KWidth.w50,
          padding: EdgeInsets.all(KRadius.r15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: SvgPicture.asset(icon),
        ),
        3.verticalSpace,
        Text(
          title,
          style: textTheme(context).labelMedium,
        )
      ],
    );
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
