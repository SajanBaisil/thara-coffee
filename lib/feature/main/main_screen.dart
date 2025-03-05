import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thara_coffee/feature/account/account_screen.dart';
import 'package:thara_coffee/feature/cart/cart_screen.dart';
import 'package:thara_coffee/feature/home/home_screen.dart';
import 'package:thara_coffee/feature/orders/orders_screen.dart';
import 'package:thara_coffee/shared/components/app_strings.dart';
import 'package:thara_coffee/shared/components/assets_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/router/responsive_helper.dart' as res;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    serviceLocator<res.ResponsiveHelper>()
      ..deviceType =
          shortestSide < 600 ? res.DeviceType.mobile : res.DeviceType.tablet
      ..deviceHeight = MediaQuery.of(context).size.height;
  }

  final mainScreenViews = [
    const HomeScreen(),
    const CartScreen(),
    const OrdersScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (context, index, _) {
            return IndexedStack(index: index, children: mainScreenViews);
          }),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (context, value, _) {
            return BottomNavigationBar(
              onTap: onTapBottomNavBarItems,
              currentIndex: value,
              items: bottomItems
                  .map((item) => BottomNavigationBarItem(
                        icon: item.icon,
                        label: item.label,
                        activeIcon: item.activeIcon,
                      ))
                  .toList(),
            );
          }),
    );
  }

  void onTapBottomNavBarItems(int value) {
    // if (selectedIndex.value == value) {
    //   serviceLocator<List<ScrollController>>(
    //           instanceName: PageControllers.scrollControllers)[value]
    //       .animateTo(0,
    //           duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    // }

    selectedIndex.value = value;

    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }
}

class BottomItem {
  BottomItem({
    required this.label,
    required this.icon,
    this.activeIcon,
  });

  final Widget icon;
  final String label;
  final Widget? activeIcon;
}

final bottomItems = [
  BottomItem(
    label: AppStrings.home,
    icon: SvgPicture.asset(SvgAssets.home),
    activeIcon: SvgPicture.asset(
      SvgAssets.home,
      color: ColorManager.primary,
    ),
  ),
  BottomItem(
    label: AppStrings.cart,
    icon: SvgPicture.asset(SvgAssets.cart),
    activeIcon: SvgPicture.asset(
      SvgAssets.cart,
      color: ColorManager.primary,
    ),
  ),
  BottomItem(
    label: AppStrings.orders,
    icon: SvgPicture.asset(SvgAssets.orders),
    activeIcon: SvgPicture.asset(
      SvgAssets.orders,
      color: ColorManager.primary,
    ),
  ),
  BottomItem(
    label: AppStrings.account,
    icon: SvgPicture.asset(SvgAssets.account),
    activeIcon: SvgPicture.asset(
      SvgAssets.account,
      color: ColorManager.primary,
    ),
  ),
];
