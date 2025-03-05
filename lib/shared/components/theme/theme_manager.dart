import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thara_coffee/shared/components/size_manager.dart';
import 'package:thara_coffee/shared/components/theme/color_manager.dart';
import 'package:thara_coffee/shared/components/theme/styles_manager.dart';
import 'package:thara_coffee/shared/components/theme/theme_getters.dart';

ThemeData getApplicationThemeLight(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    primaryColor: ColorManager.primary,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: GoogleFonts.poppins().fontFamily,
    canvasColor: ColorManager.background,
    scaffoldBackgroundColor: ColorManager.background,
    iconTheme: IconThemeData(
      color: ColorManager.secondary,
      size: KFontSize.f18,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),
    dividerColor: ColorManager.expansionTileDivider,
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      // toolbarHeight: KHeight.h230,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: ColorManager.secondary,
        size: KFontSize.f25,
      ),
      actionsIconTheme: IconThemeData(
        color: ColorManager.secondary,
        size: KFontSize.f25,
      ),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: getSemiBoldStyle(
        color: ColorManager.secondary,
        fontSize: KFontSize.f18,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorManager.whiteColor,
      surfaceTintColor: ColorManager.whiteColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      contentPadding: EdgeInsets.symmetric(
        vertical: KPadding.v15,
        horizontal: KPadding.v15,
      ),
      fillColor: ColorManager.background,
      hintStyle: getRegularStyle(
        color: ColorManager.greyTextColor,
        fontSize: KFontSize.f14,
      ),
      prefixIconColor: ColorManager.secondary,
      focusColor: ColorManager.background,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(KRadius.r10),
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: KWidth.w1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(KRadius.r10),
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: KWidth.w1,
        ),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(KRadius.r10),
      ),
      color: ColorManager.whiteColor,
      shadowColor: ColorManager.whiteColor,
    ),
    timePickerTheme: TimePickerThemeData(
      helpTextStyle: getRegularStyle(color: ColorManager.secondary),
      dayPeriodTextStyle: getRegularStyle(color: ColorManager.secondary),
      hourMinuteTextStyle: getRegularStyle(color: ColorManager.secondary),
      dayPeriodColor: ColorManager.primary,
      entryModeIconColor: ColorManager.primary,
      dialTextStyle: TextStyle(
        fontSize: KFontSize.f10,
      ),
      timeSelectorSeparatorColor:
          WidgetStateProperty.all(ColorManager.whiteColor),
      backgroundColor: ColorManager.whiteColor,
      hourMinuteTextColor: ColorManager.secondary,
      hourMinuteColor: ColorManager.background,
      dayPeriodTextColor: ColorManager.secondary,
      dialHandColor: ColorManager.primary,
      dialBackgroundColor: Colors.transparent,
      dialTextColor: ColorManager.secondary,
    ),
    datePickerTheme: DatePickerThemeData(
      cancelButtonStyle: TextButton.styleFrom(
        // Text color for the Cancel button
        textStyle: TextStyle(color: colorScheme(context).secondary),
        backgroundColor: ColorManager.transparent, // Background color
      ),
      surfaceTintColor: ColorManager.whiteColor,
      weekdayStyle: getRegularStyle(color: ColorManager.secondary),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return ColorManager.greyTextColor;
        }
        return ColorManager.secondary;
      }),
      yearForegroundColor: WidgetStateProperty.all(ColorManager.secondary),
      todayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorManager.whiteColor;
        }
        return ColorManager.secondary;
      }),
      todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return ColorManager.primary;
        }
        return Colors.transparent;
      }),
      headerBackgroundColor: ColorManager.secondary,
      dividerColor: ColorManager.lightGreyColor,
      headerHelpStyle: getRegularStyle(
        color: ColorManager.whiteColor,
        fontSize: KFontSize.f14,
      ),
      dayStyle: getRegularStyle(
        color: ColorManager.secondary,
      ),
      headerHeadlineStyle: getSemiBoldStyle(
        color: ColorManager.whiteColor,
        fontSize: KFontSize.f18,
      ),
      rangeSelectionBackgroundColor: ColorManager.whiteColor,
      rangePickerHeaderBackgroundColor: ColorManager.secondary,
      rangePickerHeaderForegroundColor: ColorManager.whiteColor,
      rangePickerBackgroundColor: ColorManager.background,
      rangePickerHeaderHelpStyle: TextStyle(
        color: ColorManager.primary,
        fontSize: KFontSize.f18,
      ),
      rangePickerHeaderHeadlineStyle: TextStyle(
        color: ColorManager.secondary,
        fontSize: KFontSize.f18,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      //white text
      displayLarge: getExtraBoldStyle(color: ColorManager.whiteColor),
      displayMedium: getMediumStyle(color: ColorManager.whiteColor),
      displaySmall: getRegularStyle(color: ColorManager.whiteColor),
      headlineLarge: getSemiBoldStyle(color: ColorManager.whiteColor),
      headlineSmall: getLightStyle(
        color: ColorManager.whiteColor,
        fontSize: KFontSize.f15,
      ),

      //black text
      headlineMedium: getMediumStyle(
        color: ColorManager.secondary,
        fontSize: KFontSize.f14,
      ),
      titleLarge: getBoldStyle(color: ColorManager.secondary),
      titleMedium: getSemiBoldStyle(
        color: ColorManager.secondary,
        fontSize: KFontSize.f15,
      ),
      titleSmall: getRegularStyle(color: ColorManager.secondary),

      //grey text
      labelLarge: getMediumStyle(color: ColorManager.greyTextColor),
      labelMedium: getRegularStyle(color: ColorManager.greyTextColor),
      labelSmall: getLightStyle(color: ColorManager.greyTextColor),

      //red
      bodyLarge: getRegularStyle(
        color: ColorManager.primary,
        fontSize: KFontSize.f9,
      ),

      //black shade - input text colo=
      bodyMedium: getRegularStyle(
        color: ColorManager.secondary,
        fontSize: KFontSize.f12,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.whiteColor,
      elevation: 0,
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: ColorManager.secondary,
      selectedLabelStyle: getRegularStyle(
        color: ColorManager.primary,
        fontSize: KFontSize.f11,
      ),
      unselectedLabelStyle: getRegularStyle(
        color: ColorManager.secondary,
        fontSize: KFontSize.f11,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    colorScheme: const ColorScheme.light(
      primary: ColorManager.primary,
      secondary: ColorManager.secondary,
      surface: ColorManager.background,
      error: ColorManager.primary,
      onSecondary: ColorManager.whiteColor,
      outline: ColorManager.expansionTileDivider,
      inverseSurface: ColorManager.darkGrey,
      onSurface: ColorManager.greyTextColor,
    ),
  );
}
