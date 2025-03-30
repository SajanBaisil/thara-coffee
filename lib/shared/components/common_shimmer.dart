import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';

class CommonShimmer extends StatelessWidget {
  const CommonShimmer({
    required this.child,
    super.key,
    this.color,
    this.highlightColor,
  });
  final Widget child;
  final Color? color;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color ?? const Color.fromARGB(255, 229, 229, 235),
      highlightColor: highlightColor ?? ColorManager.whiteColor,
      child: AbsorbPointer(
        child: child,
      ),
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
  });
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 90.w,
      height: height ?? 15.h,
      decoration: BoxDecoration(
        color: color ?? Colors.grey[100],
        borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
      ),
    );
  }
}
