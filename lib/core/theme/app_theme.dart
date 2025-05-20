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
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: AppColors.mainDark,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
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
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.mainLight,
    ),
    titleSpacing: 20,
    toolbarHeight: kToolbarHeight + 10,
    backgroundColor: AppColors.mainLight,
    elevation: 0,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
      size: 25,
      //opticalSize: Checkbox.width,
    ),
    actionsIconTheme: const IconThemeData(
      color: Colors.black,
      size: 25,
      //opticalSize: Checkbox.width,
    ),
  ),
  textTheme: lightTextTheme,
);

ThemeData get darkTheme => ThemeData(
  scaffoldBackgroundColor: AppColors.mainDark,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.mainDark,
    ),
    titleSpacing: 20,
    toolbarHeight: kToolbarHeight + 10,
    color: AppColors.mainDark,
    elevation: 0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  textTheme: darkTextTheme,
);

