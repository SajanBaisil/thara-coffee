import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thara_coffee/feature/login/screens/login_screen.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';
import 'package:thara_coffee/shared/components/web_page_screen.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/local_storage/local_storage_service.dart';
import 'package:thara_coffee/shared/router/http%20utils/http_helper.dart';
import 'package:thara_coffee/shared/router/responsive_helper.dart' as res;

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
                      onTap: () {
                        // Handle about us action
                        navigateToVisitWebsite();
                      },
                    ),
                    11.verticalSpace,
                    AccountListTileWidget(
                      title: 'Feedback',
                      icon: SvgAssets.feedback,
                      onTap: () {
                        // Handle feedback action
                        navigateToVisitWebsite();
                      },
                    ),
                    11.verticalSpace,
                    AccountListTileWidget(
                      title: 'Terms and conditions',
                      icon: SvgAssets.termsAndCondition,
                      onTap: () {
                        // Handle terms and conditions action
                        navigateToVisitWebsite();
                      },
                    ),
                    11.verticalSpace,
                    AccountListTileWidget(
                      title: 'Privacy Policy',
                      icon: SvgAssets.privacyPolicy,
                      onTap: () {
                        // Handle privacy policy action
                        navigateToVisitWebsite();
                      },
                    ),
                    19.verticalSpace,
                    InkWell(
                      onTap: () {
                        // Handle logout action
                        _handleLogout();
                      },
                      child: Container(
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

  void navigateToVisitWebsite() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => WebPageScreen(
          url: 'https://www.tharacoffee.com',
          webLoginType: WebLoginType.non,
        ),
      ),
    );
  }

  void _handleLogout() async {
    await serviceLocator<LocalStorageService>().clearLocal();
    // Perform any additional logout actions here
    // For example, navigate to the login screen or show a logout message

    HttpHelper.showCommonDialogue(
      'Are sure you want to logout',
      context,
      title: 'Logout',
      okButtonText: 'Logout',
      onTapOk: () {
        // Perform logout action
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      },
    );
  }
}

class AccountListTileWidget extends StatelessWidget {
  const AccountListTileWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final String icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: ColorManager.lightGreyColor2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      leading: SvgPicture.asset(icon),
      onTap: onTap,
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
