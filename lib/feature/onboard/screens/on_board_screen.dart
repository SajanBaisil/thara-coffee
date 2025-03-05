import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thara_coffee/feature/login/screens/login_screen.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/primary_button.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/router/responsive_helper.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final buttonController = MultiStateButtonController();
  final PageController controller = PageController();
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);
  @override
  void dispose() {
    buttonController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.primary,
        body: Stack(
          children: [
            Image.asset(ImageAssets.largeBg),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                320.verticalSpace,
                Image.asset(ImageAssets.logoHeader),
                100.verticalSpace,
                CarouselSlider(
                  options: CarouselOptions(
                    height: KHeight.h260,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    enlargeFactor: 0.3,
                    autoPlayInterval: const Duration(seconds: 5),
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      selectedIndex.value = index;
                    },
                  ),
                  items: [
                    SliderWidget(
                      subTitle:
                          'The Coffee Caravan brings the delightful aroma of freshly brewed coffee to unexpected locations.',
                      title: 'Experience coffee on the move',
                    ),
                    SliderWidget(
                        title: 'Curated artizen coffee Roasting.',
                        subTitle:
                            'Indulge in the Art of Exceptional Coffee – Where Every Bean Tells a Story.'),
                    SliderWidget(
                        title: 'Revitalize your senses, savor the moment',
                        subTitle:
                            'Savor the Brew, Ignite the Soul: Your Journey with Coffee Curing'),
                    SliderWidget(
                        title: 'Brewing perfection from Farm to Cup',
                        subTitle:
                            'With organized rows optimized for efficient cultivation, our plantations ensure the highest quality beans.')
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: KPadding.h16),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          color: ColorManager.primary,
                          borderColor: ColorManager.whiteColor,
                          controller: buttonController,
                          key: Key('login'),
                          text: 'Login',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          isOutLined: true,
                          borderRadius: KRadius.r100,
                        ),
                      ),
                    ],
                  ),
                ),
                40.verticalSpace,
                ValueListenableBuilder(
                    valueListenable: selectedIndex,
                    builder: (context, index, _) {
                      return AnimatedSmoothIndicator(
                        effect: ExpandingDotsEffect(
                          dotColor:
                              colorScheme(context).onSecondary.withOpacity(0.5),
                          dotWidth: serviceLocator<ResponsiveHelper>().isTablet
                              ? 4.w
                              : 12.w,
                          dotHeight: serviceLocator<ResponsiveHelper>().isTablet
                              ? 4.w
                              : 8.h,
                          spacing: serviceLocator<ResponsiveHelper>().isTablet
                              ? 3.w
                              : 6.w,
                          activeDotColor: colorScheme(context).onSecondary,
                        ),
                        activeIndex: index,
                        count: 4,
                      );
                    })
              ],
            )
          ],
        ));
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: textTheme(context)
              .displayLarge
              ?.copyWith(fontSize: KFontSize.f35, fontWeight: FontWeight.bold),
        ),
        12.verticalSpace,
        IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: KWidth.w2,
                color: ColorManager.whiteColor,
              ),
              14.horizontalSpace,
              Expanded(
                child: Text(
                  subTitle,
                  style: textTheme(context)
                      .displaySmall
                      ?.copyWith(fontSize: KFontSize.f15),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
