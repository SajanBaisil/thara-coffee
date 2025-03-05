import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';

class LabeledTextField extends StatelessWidget {
  const LabeledTextField(
      {required this.controller,
      this.suffix,
      this.labelText,
      super.key,
      this.enabled = true,
      this.paddingAround = true,
      this.validator,
      this.inputFormatters,
      this.hintText,
      this.hintTextStyle,
      this.counterText,
      this.keyboardType = TextInputType.text,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.focusNode,
      this.nextFocusNode,
      this.onChanged,
      this.autofillHints,
      this.onSaved,
      this.leading,
      this.obscureText = false,
      this.formFieldKey,
      this.maxLines,
      this.minLines,
      this.fillColor,
      this.prefixIcon,
      this.borderRadius,
      this.borderColor,
      this.inputTextColor,
      this.scrollPadding,
      this.labelStyle,
      this.obscureCharacter,
      this.onTap,
      this.textStyle,
      this.decoration,
      this.textAlign = TextAlign.start,
      this.maxLength,
      this.heading,
      this.isMandatory = false,
      this.readOnly = false});
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final String? counterText;
  final Widget? suffix;
  final Widget? prefixIcon;
  final bool enabled;
  final TextStyle? textStyle;
  final bool paddingAround;
  final TextStyle? hintTextStyle;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final AutovalidateMode autovalidateMode;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final FocusNode? nextFocusNode;
  final Widget? leading;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final Function()? onTap;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final GlobalKey<FormFieldState<dynamic>>? formFieldKey;
  final double? borderRadius;
  final Color? borderColor;
  final Color? inputTextColor;
  final Color? fillColor;
  final EdgeInsets? scrollPadding;
  final TextStyle? labelStyle;
  final String? obscureCharacter;
  final InputDecoration? decoration;
  final TextAlign textAlign;
  final String? heading;
  final bool isMandatory;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(paddingAround ? 6.r : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (heading != null)
            Column(
              children: [
                Text.rich(
                  TextSpan(
                    text: heading,
                    style: textTheme(context).headlineMedium,
                    children: [
                      if (isMandatory)
                        TextSpan(
                          text: '*',
                          style: textTheme(context).headlineMedium?.copyWith(
                                color: Colors.red,
                                fontSize: KFontSize.f16,
                              ),
                        ),
                    ],
                  ),
                ),
                6.verticalSpace,
              ],
            ),
          TextFormField(
            textAlign: textAlign,
            onSaved: onSaved,
            onTapOutside: (event) => context.hideKeyboard(),
            maxLength: maxLength,
            key: formFieldKey,
            autofillHints: autofillHints,
            onFieldSubmitted: (value) {
              focusNode?.unfocus();
              FocusScope.of(context).requestFocus(nextFocusNode);
            },
            maxLines: maxLines ?? 1,
            minLines: minLines ?? 1,
            onChanged: onChanged,
            onTap: onTap,
            autovalidateMode: autovalidateMode,
            obscuringCharacter: obscureCharacter ?? '•',
            obscureText: obscureText,
            inputFormatters: inputFormatters ?? [],
            focusNode: focusNode,
            keyboardType: keyboardType,
            validator: validator,
            enabled: enabled,
            readOnly: readOnly,
            scrollPadding: scrollPadding ??
                const EdgeInsets.only(
                  bottom: 200,
                ),
            controller: controller,
            style: textStyle ??
                theme.textTheme.bodyMedium?.copyWith(
                    fontSize: KFontSize.f14,
                    color: inputTextColor ?? ColorManager.primary,
                    decoration: TextDecoration.none,
                    decorationThickness: 0),
            decoration: decoration ??
                InputDecoration(
                  border: InputBorder.none,
                  fillColor: fillColor ?? ColorManager.textFieldColor,
                  errorMaxLines: 5,
                  counterText: counterText,
                  prefixIcon: prefixIcon,
                  prefix: leading,
                  prefixStyle: textStyle ??
                      theme.textTheme.bodyMedium?.copyWith(
                          fontSize: KFontSize.f14,
                          color: inputTextColor ?? ColorManager.secondary,
                          decoration: TextDecoration.none,
                          decorationThickness: 0),
                  suffixIcon: suffix != null
                      ? Material(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.transparent,
                          child: suffix,
                        )
                      : null,
                  labelText: labelText,
                  labelStyle: labelStyle ??
                      theme.textTheme.labelMedium
                          ?.copyWith(fontSize: KFontSize.f14),
                  alignLabelWithHint: true,
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: borderColor ?? const Color(0xffBEBEBE)),
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius ?? 15.r)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: borderColor ?? const Color(0xffBEBEBE)),
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius ?? 15.r)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: borderColor ?? const Color(0xffBEBEBE)),
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius ?? 15.r)),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorManager.red),
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius ?? 15.r)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorManager.red),
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius ?? 15.r)),
                  ),
                  hintText: hintText ?? labelText,
                  hintStyle: hintTextStyle,
                  errorStyle: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: KFontSize.f12,
                      color: ColorManager.red,
                      decoration: TextDecoration.none,
                      decorationThickness: 0),
                ),
          ),
        ],
      ),
    );
  }
}

extension KeyboardExtension on BuildContext {
  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
