import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thara_coffee/feature/home/logic/home_bloc/home_bloc.dart';
import 'package:thara_coffee/feature/login/logic/login_bloc/login_bloc.dart';
import 'package:thara_coffee/feature/onboard/screens/on_board_screen.dart';
import 'package:thara_coffee/shared/components/theme/theme_manager.dart';
import 'package:thara_coffee/shared/service_locator_setup/setup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        fontSizeResolver: (fontSize, instance) => fontSize * 1.1,
        designSize: const Size(412, 917),
        useInheritedMediaQuery: true,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return HeroControllerScope(
            controller: MaterialApp.createMaterialHeroController(),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => LoginBloc(),
                ),
                BlocProvider(
                  create: (context) => HomeBloc(),
                ),
              ],
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  primaryFocus?.unfocus();
                },
                child: MaterialApp(
                  title: 'Thara Coffee',
                  theme: getApplicationThemeLight(context),
                  home: OnBoardingScreen(),
                ),
              ),
            ),
          );
        });
  }
}
