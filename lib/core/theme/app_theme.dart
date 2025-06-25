import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';


TextTheme get lightTextTheme => TextTheme(
      displayLarge: TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.bold,
        color: AppColors.mainDark,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.mainDark,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.mainDark,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.mainDark,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.mainDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: AppColors.mainDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.mainDark,
      ),
      bodySmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.mainDark,
      ),
    );

TextTheme get darkTextTheme => TextTheme(
  displayLarge: TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  ),
  displayMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  ),
  displaySmall: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  ),
  titleLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  ),
  labelLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  ),
  bodyLarge: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  ),
);

ThemeData get lightTheme => ThemeData(
  scaffoldBackgroundColor: AppColors.mainLight,
  primaryColor: AppColors.darkRed,
  primaryColorDark: AppColors.lightRed,
  primaryColorLight: AppColors.darkRed,
  canvasColor: AppColors.mainLight,
  indicatorColor: AppColors.darkRed,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.darkRed,
    selectionColor: AppColors.darkRed,
    selectionHandleColor: AppColors.darkRed,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.mainLight,
    ),
    titleSpacing: 20,
    toolbarHeight: kToolbarHeight + 10,
    backgroundColor: AppColors.mainLight,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    titleTextStyle: const TextStyle(
      color: AppColors.blackColor,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.blackColor,
      size: 25,
      //opticalSize: Checkbox.width,
    ),
    actionsIconTheme: const IconThemeData(
      color: AppColors.blackColor,
      size: 25,
      //opticalSize: Checkbox.width,
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.mainDark,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.darkRed, // CircularProgressIndicator color
    linearTrackColor: AppColors.darkRed.withValues(alpha: 0.4),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.mainDark),
    ),
    labelStyle: TextStyle(color: AppColors.mainDark),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(AppColors.darkRed),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(AppColors.mainDark),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(AppColors.mainDark),
  ),
  textTheme: lightTextTheme,
);

ThemeData get darkTheme => ThemeData(
  scaffoldBackgroundColor: AppColors.mainDark,
  primaryColor: AppColors.lightRed,
  primaryColorDark: AppColors.darkRed,
  primaryColorLight: AppColors.lightRed,
  canvasColor: AppColors.mainDark,
  indicatorColor: AppColors.lightRed,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.lightRed,             // blinking cursor color
    selectionColor: AppColors.lightRed,    // highlight color
    selectionHandleColor: AppColors.lightRed,    // color of the selection handles (the little pointers)
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.mainDark,
    ),
    titleSpacing: 20,
    toolbarHeight: kToolbarHeight + 10,
    color: AppColors.mainDark,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    scrolledUnderElevation: 0,
    titleTextStyle: const TextStyle(
      color: AppColors.mainLight,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    actionsIconTheme: const IconThemeData(
      color: AppColors.mainLight,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.mainLight,
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.lightRed, // CircularProgressIndicator color
    linearTrackColor: AppColors.lightRed.withValues(alpha: 0.4),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.mainLight),
    ),
    labelStyle: TextStyle(color: AppColors.mainLight),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(AppColors.lightRed),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(AppColors.mainLight),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all(AppColors.mainLight),
  ),
  textTheme: darkTextTheme,
);

