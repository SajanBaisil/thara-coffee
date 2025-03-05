import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:thara_coffee/feature/login/widgets/common_auth_screen.dart';
import 'package:thara_coffee/feature/main/main_screen.dart';
import 'package:thara_coffee/shared/components/common_pinput.dart';
import 'package:thara_coffee/shared/components/primary_button.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final pinputController = TextEditingController();
  final buttonController = MultiStateButtonController();

  @override
  void dispose() {
    pinputController.dispose();
    buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonAuthScreen(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: KPadding.h50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            70.verticalSpace,
            Text(
              'Enter OTP',
              style: textTheme(context)
                  .titleSmall
                  ?.copyWith(fontSize: KFontSize.f18),
            ),
            3.verticalSpace,
            Text(
              'We are automatically detecting a SMS send to your mobile number',
              textAlign: TextAlign.center,
              style: textTheme(context).titleSmall?.copyWith(
                  fontSize: KFontSize.f14, color: ColorManager.lightGrey),
            ),
            21.verticalSpace,
            CommonPinput(
              showPin: false,
              pinputKey: Key('pin-put'),
              length: 4,
              controller: pinputController,
            ),
            40.verticalSpace,
            PrimaryButton(
                width: KWidth.w190,
                key: Key('get-otp'),
                controller: buttonController,
                color: ColorManager.primary,
                borderRadius: KRadius.r100,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MainScreen();
                  }));
                },
                text: 'Done'),
            130.verticalSpace,
          ],
        ),
      ),
    );
  }
}
