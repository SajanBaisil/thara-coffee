import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';

class CommonPinput extends StatelessWidget {
  const CommonPinput(
      {required bool showPin,
      required this.controller,
      required this.length,
      required this.pinputKey,
      super.key,
      this.scrollPadding,
      this.validator,
      this.onCompleted,
      this.obscuringWidget,
      this.focusNode,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.width})
      : showPin = true;

  final bool showPin;
  final TextEditingController controller;
  final int length;
  final String? Function(String?)? validator;
  final EdgeInsets? scrollPadding;
  final void Function(String)? onCompleted;
  final FocusNode? focusNode;
  final Widget? obscuringWidget;
  final Key pinputKey;
  final MainAxisAlignment mainAxisAlignment;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Pinput(
      mainAxisAlignment: mainAxisAlignment,
      focusNode: focusNode,
      key: pinputKey,
      length: length,
      scrollPadding: scrollPadding ?? EdgeInsets.only(bottom: KPadding.h150),
      obscureText: !showPin,
      validator: validator,
      errorTextStyle: theme.textTheme.bodyLarge?.copyWith(
        fontSize: KFontSize.f11,
        color: ColorManager.red,
      ),
      obscuringWidget: obscuringWidget,
      disabledPinTheme: PinTheme(
        width: width ?? KWidth.w56,
        height: KHeight.h56,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(KRadius.r14),
          border: Border.all(
            color: ColorManager.greyTextColor,
          ),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: width ?? KWidth.w56,
        height: KHeight.h56,
        decoration: BoxDecoration(
          color: ColorManager.errorColor,
          borderRadius: BorderRadius.circular(KRadius.r14),
          border: Border.all(
            color: ColorManager.transparent,
          ),
        ),
        textStyle: theme.textTheme.bodyLarge!.copyWith(
          fontSize: KFontSize.f18,
          color: ColorManager.whiteColor,
        ),
      ),
      focusedPinTheme: PinTheme(
        width: width ?? KWidth.w56,
        height: KHeight.h56,
        textStyle: theme.textTheme.bodyLarge!.copyWith(
          fontSize: KFontSize.f18,
          color: ColorManager.whiteColor,
        ),
        decoration: BoxDecoration(
          color: ColorManager.errorColor,
          borderRadius: BorderRadius.circular(KRadius.r14),
          border: Border.all(
            color: ColorManager.lightGreyColor,
          ),
        ),
      ),
      defaultPinTheme: PinTheme(
        width: width ?? KWidth.w56,
        height: KHeight.h56,
        decoration: BoxDecoration(
          color: ColorManager.errorColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(KRadius.r14),
          border: Border.all(color: ColorManager.transparent),
        ),
        textStyle: theme.textTheme.bodyLarge!.copyWith(
          fontSize: KFontSize.f18,
          color: ColorManager.whiteColor,
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      pinAnimationType: PinAnimationType.fade,
      animationCurve: Curves.easeInOut,
      showCursor: false,
      controller: controller,
      onSubmitted: (value) {
        print('onSubmit');
      },
      onCompleted: (value) {
        onCompleted?.call(value);
      },
    );
  }
}
