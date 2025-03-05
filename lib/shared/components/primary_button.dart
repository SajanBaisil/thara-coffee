import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/styles_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    required super.key,
    required this.controller,
    required this.text,
    this.enabled = true,
    this.isOutLined = false,
    this.iconPosition = IconPosition.left,
    this.height,
    this.width,
    this.color,
    this.padding,
    this.onPressed,
    this.textColor,
    this.borderRadius,
    this.borderColor,
    this.iconImage,
    this.textSize,
    this.textStyle,
    this.loadingColor,
    this.gradientColors,
  });

  final MultiStateButtonController controller;
  final String text;
  final bool enabled;
  final double? width;
  final double? height;
  final Color? color;
  final Widget? iconImage;
  final Color? borderColor;
  final bool isOutLined;
  final Color? textColor;
  final double? textSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final void Function()? onPressed;
  final IconPosition iconPosition;
  final TextStyle? textStyle;
  final Color? loadingColor;
  final Gradient? gradientColors;
  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;

    return MultiStateButton(
      key: ValueKey(widget.key.hashCode.toString()),
      multiStateButtonController: widget.controller,
      buttonStates: [
        //submit state
        ButtonState(
          stateName: ButtonStates.idle,
          child: FittedBox(
            child: Row(
              children: [
                if (widget.iconPosition == IconPosition.left)
                  widget.iconImage ?? const SizedBox.shrink()
                else
                  const SizedBox.shrink(),
                Text(
                  widget.text,
                  style: widget.textStyle ??
                      getBoldStyle(
                        fontSize: widget.textSize ?? 16.sp,
                        color: widget.textColor ?? theme.surface,
                      ),
                ),
                if (widget.iconPosition == IconPosition.right)
                  widget.iconImage ?? const SizedBox.shrink()
                else
                  const SizedBox.shrink(),
              ],
            ),
          ),
          decoration: BoxDecoration(
            gradient: widget.gradientColors,
            border: widget.isOutLined
                ? Border.all(
                    color: widget.borderColor ?? theme.primary,
                  )
                : null,
            color: widget.gradientColors != null ? null : widget.color,
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? 5.r,
            ),
          ),
          textStyle: widget.textStyle ??
              getMediumStyle(color: theme.tertiary, fontSize: 16.sp),
          size: Size(widget.width ?? size.width * .76, widget.height ?? 45.h),
          color: widget.color ?? ColorManager.primary,
          onPressed: widget.enabled ? widget.onPressed : null,
        ),
        //loading state
        ButtonState(
          stateName: ButtonStates.loading,
          child: Center(
            child: LoadingAnimationWidget.progressiveDots(
              color: widget.loadingColor ?? colorScheme(context).secondary,
              size: KWidth.w30,
            ),
          ),
          decoration: BoxDecoration(
            gradient: widget.gradientColors,
            border: widget.isOutLined
                ? Border.all(
                    color: theme.primary,
                  )
                : null,
            color: widget.gradientColors != null ? null : widget.color,
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? 10.r,
            ),
          ),
          textStyle: widget.textStyle ??
              getMediumStyle(color: theme.tertiary, fontSize: 16.sp),
          size: Size(widget.width ?? size.width * .76, widget.height ?? 50.h),
          color: widget.color ?? ColorManager.primary,
          // onPressed: widget.onPressed ?? () {},
        ),

        //success button
        ButtonState(
          stateName: ButtonStates.success,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              widget.loadingColor ?? colorScheme(context).secondary,
              BlendMode.srcIn,
            ),
            child: Lottie.asset(
              LottieAssets.success,
              repeat: false,
              height: KHeight.h30,
              width: KWidth.w30,
              // delegates: LottieDelegates(
              //   values: [
              //     ValueDelegate.color(
              //       // keyPath order: ['layer name', 'group name', 'shape name']
              //       const ['**', 'wave_2 Outlines', '**'],
              //       value: widget.loadingColor ?? colorScheme(context).secondary,
              //     ),
              //   ],
              // ),
            ),
          ),
          decoration: BoxDecoration(
            gradient: widget.gradientColors,
            border: widget.isOutLined
                ? Border.all(
                    color: theme.primary,
                  )
                : null,
            color: widget.gradientColors != null ? null : widget.color,
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? 10.r,
            ),
          ),
          textStyle: widget.textStyle ??
              getMediumStyle(color: theme.tertiary, fontSize: 16.sp),
          size: Size(widget.width ?? size.width * .76, widget.height ?? 50.h),
          color: widget.color ?? ColorManager.primary,
          // onPressed: widget.onPressed ?? () {},
        ),
      ],
    );
  }
}

enum IconPosition { right, left }

class ButtonStates {
  static const String idle = 'idle';
  static const String loading = 'loading';
  static const String success = 'success';
}
