import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_state_button/multi_state_button.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/primary_button.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/router/responsive_helper.dart' as res;

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  final doneController = MultiStateButtonController();

  @override
  void dispose() {
    doneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = serviceLocator<res.ResponsiveHelper>().isSmallScreen;

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
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          // SvgPicture.asset(SvgAssets.coffeeCup),
          //   ],
          // )
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 46.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      333.verticalSpace,
                      SvgPicture.asset(SvgAssets.coffeeCup),
                      22.verticalSpace,
                      Text(
                        ' Your order has been\nsuccessfully Placed.',
                        textAlign: TextAlign.center,
                        style: textTheme(context)
                            .labelMedium
                            ?.copyWith(fontSize: KFontSize.f14),
                      ),
                      53.verticalSpace,
                      PrimaryButton(
                          key: Key('done'),
                          width: double.infinity,
                          controller: doneController,
                          color: ColorManager.primary,
                          borderRadius: KRadius.r100,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: 'Done'),
                      isSmallScreen ? 180.verticalSpace : 247.verticalSpace,
                      // richtext
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Need help? Visit our ',
                              style: textTheme(context).titleSmall?.copyWith(
                                    color: ColorManager.black70,
                                    fontSize: KFontSize.f13,
                                  ),
                            ),
                            TextSpan(
                              text: ' help center',
                              style: textTheme(context).titleMedium?.copyWith(
                                    color: ColorManager.primary,
                                    fontSize: KFontSize.f13,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
