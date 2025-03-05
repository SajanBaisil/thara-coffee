import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:thara_coffee/feature/login/screens/verify_otp_screen.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/labeled_textfield.dart';
import 'package:thara_coffee/shared/components/primary_button.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    super.key,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final buttonController = MultiStateButtonController();

  @override
  void dispose() {
    loginController.dispose();
    phoneNumberController.dispose();
    buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: KPadding.h50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          58.verticalSpace,
          Text(
            'Login',
            style: textTheme(context)
                .titleSmall
                ?.copyWith(fontSize: KFontSize.f18),
          ),
          3.verticalSpace,
          Text(
            'Enter your details',
            style: textTheme(context).titleSmall?.copyWith(
                fontSize: KFontSize.f14, color: ColorManager.lightGrey),
          ),
          21.verticalSpace,
          LabeledTextField(
            prefixIcon: Padding(
                padding: EdgeInsets.all(KPadding.h10),
                child: SvgPicture.asset(
                  SvgAssets.person,
                  height: KHeight.h10,
                  width: KWidth.w10,
                )),
            controller: loginController,
            fillColor: ColorManager.whiteColor,
            hintText: 'Name',
          ),
          8.verticalSpace,
          LabeledTextField(
            prefixIcon: Padding(
              padding: EdgeInsets.all(KPadding.h10),
              child: SvgPicture.asset(
                SvgAssets.dialPad,
                height: KHeight.h10,
                width: KWidth.w10,
              ),
            ),
            controller: phoneNumberController,
            fillColor: ColorManager.whiteColor,
            hintText: '999 999 99 99',
          ),
          25.verticalSpace,
          PrimaryButton(
              key: Key('get-otp'),
              width: KWidth.w190,
              controller: buttonController,
              color: ColorManager.primary,
              borderRadius: KRadius.r100,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const VerifyOtpScreen();
                }));
              },
              text: 'Get OTP'),
          70.verticalSpace,
        ],
      ),
    );
  }
}
