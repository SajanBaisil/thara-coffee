import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';

class CustomDropDown<T> extends StatefulWidget {
  const CustomDropDown({
    this.icon,
    required this.values,
    this.value,
    this.onChanged,
    super.key,
    this.displayName,
    this.height,
    this.onTap,
    this.customizeAction = false,
    this.backGroundColor,
    this.displayNameColor,
    this.borderColor,
    this.suffixIcon,
    this.borderRadius,
    this.padding,
    this.hintText,
    this.hintStyle,
    this.validator,
    this.textStyle,
  });
  final String? icon;
  final T? value;
  final void Function(T selected)? onChanged;
  final List<T> values;
  final String Function(T)? displayName;
  final double? height;
  final bool customizeAction;
  final void Function()? onTap;
  final Color? backGroundColor;
  final Color? borderColor;
  final Color? displayNameColor;
  final String? suffixIcon;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final String? Function(T?)? validator;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  final GlobalKey dropDownKey = GlobalKey();
  final GlobalKey containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(KRadius.r10),
                onTap: () {
                  if (widget.customizeAction) {
                    if (widget.onTap != null) {
                      widget.onTap!.call();
                      return;
                    }
                  } else {
                    dropDownKey.currentContext?.visitChildElements((element) {
                      if (element.widget is Semantics) {
                        element.visitChildElements((element) {
                          if (element.widget is Actions) {
                            element.visitChildElements((element) {
                              Actions.invoke(element, const ActivateIntent());
                            });
                          }
                        });
                      }
                    });
                  }
                },
                child: Container(
                  key: containerKey,
                  // height: widget.height ?? KHeight.h35,
                  width: double.infinity,
                  padding: widget.padding ?? EdgeInsets.all(KRadius.r12),
                  decoration: BoxDecoration(
                    color: widget.backGroundColor ?? ColorManager.darkGrey,
                    border: Border.all(
                      color: field.hasError
                          ? ColorManager.red
                          : widget.borderColor ?? ColorManager.darkGrey,
                    ),
                    borderRadius: widget.borderRadius ??
                        BorderRadius.circular(KRadius.r10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.icon != null)
                        Row(
                          children: [
                            SvgPicture.asset(
                              widget.icon!,
                            ),
                            KSize.w5,
                          ],
                        ),
                      Expanded(
                        child: AbsorbPointer(
                          absorbing: widget.customizeAction,
                          child: DropdownButton<dynamic>(
                            key: dropDownKey,
                            value: widget.value,
                            hint: Text(widget.hintText ?? "",
                                style: widget.hintStyle ??
                                    textTheme(context).bodyMedium?.copyWith(
                                        fontSize: KFontSize.f14,
                                        color: ColorManager.textFieldTextColor,
                                        decoration: TextDecoration.none,
                                        decorationThickness: 0)),
                            padding: EdgeInsets.zero,
                            icon: const SizedBox(),
                            dropdownColor: widget.backGroundColor,
                            underline: const SizedBox(),
                            isDense: true,
                            style: textTheme(context).bodyMedium?.copyWith(
                                fontSize: KFontSize.f14,
                                color: ColorManager.textFieldTextColor,
                                decoration: TextDecoration.none,
                                decorationThickness: 0),
                            items: widget.values
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      widget.displayName?.call(e) ??
                                          e.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: widget.textStyle ??
                                          textTheme(context)
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontSize: KFontSize.f12,
                                                  color: ColorManager
                                                      .textFieldTextColor),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              widget.onChanged?.call(value as T);
                              field.didChange(value as T);
                            },
                          ),
                        ),
                      ),
                      if (widget.suffixIcon == null)
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: ColorManager.secondary,
                          size: KRadius.r20,
                        )
                      else
                        SvgPicture.asset(
                          widget.suffixIcon!,
                        ),
                    ],
                  ),
                ),
              ),
              if (field.hasError)
                Padding(
                  padding:
                      EdgeInsets.only(top: KPadding.v5, left: KPadding.h15),
                  child: Text(
                    field.errorText!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          );
        });
  }
}
