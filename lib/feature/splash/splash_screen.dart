import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thara_coffee/feature/main/main_screen.dart';
import 'package:thara_coffee/feature/onboard/screens/on_board_screen.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/local_storage/keys.dart';
import 'package:thara_coffee/shared/local_storage/local_storage_service.dart';
import 'package:thara_coffee/shared/router/responsive_helper.dart' as res;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      await Future.delayed(
          const Duration(seconds: 2)); // Allow animation to play

      final loginResponse =
          await serviceLocator<LocalStorageService>().getFromLocal(
        LocalStorageKeys.loginResponse,
      );
      if (!mounted) return;
      if (loginResponse != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = serviceLocator<res.ResponsiveHelper>().isSmallScreen;
    final isLargeScreen = serviceLocator<res.ResponsiveHelper>().isLargeScreen;
    final isTallScreen = serviceLocator<res.ResponsiveHelper>().isTallScreen;
    return Scaffold(
      backgroundColor: ColorManager.primary,
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
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate([
                isSmallScreen
                    ? 250.verticalSpace
                    : isLargeScreen
                        ? 290.verticalSpace
                        : (isTallScreen && !isLargeScreen)
                            ? 300.verticalSpace
                            : 320.verticalSpace,
                Image.asset(ImageAssets.logoHeader)
                    .animate()
                    .fadeIn(
                      duration: 1500.ms,
                      curve: Curves.easeInOut,
                    )
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.0, 1.0),
                      duration: 1500.ms,
                      curve: Curves.easeInOut,
                    ),
                isSmallScreen ? 90.verticalSpace : 100.verticalSpace,
              ]))
            ],
          ),
        ],
      ),
    );
  }
}
