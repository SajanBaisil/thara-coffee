import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.whiteColor,
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
                        color: ColorManager.fdf1f1,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: CustomScrollView(slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Text(
                        'Your Orders',
                        style: textTheme(context)
                            .headlineMedium
                            ?.copyWith(fontSize: KFontSize.f20),
                      ),
                      16.verticalSpace,
                      OrderWidget(
                        title: 'Cappuccino',
                        subTitle: 'with chocolate',
                        color: ColorManager.greenColorWithAlpha,
                        borderColor: ColorManager.greenColor,
                      ),
                      21.verticalSpace,
                      OrderWidget(
                        title: 'Cappuccino',
                        subTitle: 'with chocolate',
                        color: ColorManager.orangeColorWithAlpha,
                        borderColor: ColorManager.orangeColor,
                      ),
                      21.verticalSpace,
                      OrderWidget(
                        title: 'Cappuccino',
                        subTitle: 'without sugar',
                        color: ColorManager.redColorWithAlpha,
                        borderColor: ColorManager.primary,
                      ),
                    ]),
                  ),
                )
              ]),
            ),
          ],
        ));
  }
}

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.color,
    required this.borderColor,
  });

  final String title;
  final String subTitle;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(right: 13.w, top: 24.h, left: 17.w, bottom: 16.h),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        border: Border.all(color: ColorManager.eee),
        borderRadius: BorderRadius.circular(KRadius.r15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme(context).displayMedium?.copyWith(
                        fontSize: KFontSize.f14, color: ColorManager.secondary),
                  ),
                  Text(
                    subTitle,
                    style: textTheme(context).displaySmall?.copyWith(
                        fontSize: KFontSize.f12,
                        color: ColorManager.grey8D8D8D),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(KRadius.r10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: ColorManager.eee),
                    child: Icon(Icons.remove),
                  ),
                  6.horizontalSpace,
                  Container(
                    padding: EdgeInsets.all(KRadius.r15),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: ColorManager.errorColor),
                    child: Text(
                      '3',
                      style: textTheme(context)
                          .headlineLarge
                          ?.copyWith(fontSize: KFontSize.f20),
                    ),
                  ),
                  7.horizontalSpace,
                  Container(
                    padding: EdgeInsets.all(KRadius.r10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: ColorManager.grey4F4F4F),
                    child: Icon(
                      Icons.add,
                      color: ColorManager.whiteColor,
                    ),
                  )
                ],
              )
            ],
          ),
          13.verticalSpace,
          Divider(
            color: ColorManager.f1f1f1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Cooking Status',
                    style: textTheme(context).displaySmall?.copyWith(
                        fontSize: KFontSize.f12,
                        color: ColorManager.grey8D8D8D),
                  ),
                  7.horizontalSpace,
                  Container(
                      padding: EdgeInsets.only(
                          left: 12.w, top: 4.h, right: 7.w, bottom: 4.h),
                      decoration: BoxDecoration(
                          color: color,
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(KRadius.r5)),
                      child: Text('Ready'))
                ],
              ),
              Text(
                '₹ 298.00',
                style: textTheme(context)
                    .titleMedium
                    ?.copyWith(fontSize: KFontSize.f18),
              )
            ],
          )
        ],
      ),
    );
  }
}
