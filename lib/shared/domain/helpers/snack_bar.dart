import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';

Color getSnackBarColor(SnackBarType snackBarType) {
  if (snackBarType == SnackBarType.info) {
    return Colors.green;
  } else if (snackBarType == SnackBarType.error) {
    return Colors.red;
  } else if (snackBarType == SnackBarType.success) {
    return ColorManager.primary;
  } else if (snackBarType == SnackBarType.warning) {
    return const Color.fromARGB(255, 44, 47, 47);
  }
  return Colors.black;
}

void showSnackBar(
  String message,
  BuildContext context, {
  IconData? icon,
  Color? color,
  Color backgroundColor = Colors.black,
  bool isWarning = false,
  bool isInfinite = false,
  double bottomPadding = 50,
  SnackBarType snackBarType = SnackBarType.validation,
}) {
  if (!context.mounted) return;
  HapticFeedback.heavyImpact();
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: ColorManager.settingsTileTextColor,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
      // backgroundColor: color ?? getSnackBarColor(snackBarType),
      duration: isInfinite
          ? const Duration(days: 1)
          : Duration(seconds: message.length > 40 ? 5 : 2),
    ),
    // )
  );
}

enum SnackBarType {
  warning,
  error,
  validation,
  success,
  info,
}
