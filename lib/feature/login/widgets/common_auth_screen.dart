import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/router/responsive_helper.dart' as res;

class CommonAuthScreen extends StatefulWidget {
  const CommonAuthScreen({super.key, required this.child});
  final Widget child;

  @override
  State<CommonAuthScreen> createState() => _CommonAuthScreenState();
}

class _CommonAuthScreenState extends State<CommonAuthScreen> {
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = serviceLocator<res.ResponsiveHelper>().isSmallScreen;
    final isLargeScreen = serviceLocator<res.ResponsiveHelper>().isLargeScreen;
    final isTallScreen = serviceLocator<res.ResponsiveHelper>().isTallScreen;

    return Scaffold(
      backgroundColor: ColorManager.primary,
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
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate([
                isSmallScreen
                    ? 250.verticalSpace
                    : isLargeScreen
                        ? 240.verticalSpace
                        : (isTallScreen && !isLargeScreen)
                            ? 300.verticalSpace
                            : 320.verticalSpace,
                Image.asset(ImageAssets.logoHeader),
                isSmallScreen ? 90.verticalSpace : 100.verticalSpace,
                IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(KRadius.r25),
                        topRight: Radius.circular(KRadius.r25),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Image.asset(
                          ImageAssets.smallBg,
                          color: ColorManager.fdf1f1,
                        ),
                        widget.child
                      ],
                    ),
                  ),
                ),
              ]))
            ],
          ),
        ],
      ),
    );
  }
}
