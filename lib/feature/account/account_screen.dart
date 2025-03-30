import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/router/responsive_helper.dart' as res;

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
          SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  sliver: SliverList(
                      delegate: SliverChildListDelegate([
                    30.verticalSpace,
                    AccountListTileWidget(
                      title: 'About Us',
                      icon: SvgAssets.info,
                    ),
                    11.verticalSpace,
                    AccountListTileWidget(
                      title: 'Feedback',
                      icon: SvgAssets.feedback,
                    ),
                    11.verticalSpace,
                    AccountListTileWidget(
                      title: 'Terms and conditions',
                      icon: SvgAssets.termsAndCondition,
                    ),
                    11.verticalSpace,
                    AccountListTileWidget(
                      title: 'Privacy Policy',
                      icon: SvgAssets.privacyPolicy,
                    ),
                    19.verticalSpace,
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 100.w : 120.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: ColorManager.ffebeb,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(SvgAssets.logout),
                          9.horizontalSpace,
                          Text('Logout',
                              style: textTheme(context).titleSmall?.copyWith(
                                    fontSize: KFontSize.f18,
                                    color: ColorManager.redColor,
                                  ))
                        ],
                      ),
                    )
                  ])),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AccountListTileWidget extends StatelessWidget {
  const AccountListTileWidget({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: ColorManager.lightGreyColor2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      leading: SvgPicture.asset(icon),
      title: Text(
        title,
        style: textTheme(context).titleSmall?.copyWith(
              fontSize: KFontSize.f18,
              color: ColorManager.darkGreyColor,
            ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: ColorManager.darkGreyColor,
      ),
    );
  }
}
