import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/labeled_textfield.dart';
import 'package:thara_coffee/shared/components/primary_button.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';

class CommonAuthScreen extends StatefulWidget {
  const CommonAuthScreen({super.key, required this.child});
  final Widget child;

  @override
  State<CommonAuthScreen> createState() => _CommonAuthScreenState();
}

class _CommonAuthScreenState extends State<CommonAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(ImageAssets.largeBg),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                320.verticalSpace,
                Center(child: Image.asset(ImageAssets.logoHeader)),
                100.verticalSpace,
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
                        Image.asset(ImageAssets.smallBg),
                        widget.child
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}


