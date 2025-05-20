import 'package:flutter/material.dart';

abstract class AppColors {
  static Color lightRed = const Color(0xffB44E4E);
  static Color darkRed = const Color(0xff8C3A3A);
  static Color lightBlue = const Color(0xff728CAC);
  static Color darkBlue = const Color(0xff304F73);
  static Color mainDark = const Color(0xff2D3748);
  static Color mainLight = const Color(0xffE9EDF4);
  static Color medium = const Color(0xff9A9A9A);
  static Color light = const Color(0xffCDCDCD);
  static Color white = const Color(0xffffffff);
}

class ThemedColors {
  late Color primary;
  late Color secondary;
  late Color red;
  late Color blue;

  ThemedColors(bool isLightTheme){
    primary = isLightTheme ? AppColors.mainLight : AppColors.mainDark;
    secondary = isLightTheme ? AppColors.mainDark : AppColors.mainLight;
    red = isLightTheme ? AppColors.darkRed : AppColors.lightRed;
    blue = isLightTheme ? AppColors.darkBlue : AppColors.lightBlue;
  }
}

const Color whiteColor = Colors.white;
const Color blackColor = Color.fromRGBO(12, 16, 27, 1.0);
const Color mainDarkColor = Color(0xff2D3748);
const Color darkRedColor = Color(0xff8C3A3A);
const Color lightRedColor = Color(0xffB44E4E);
const Color mainLightColor = Color(0xffE9EDF4);
const Color darkBlueColor = Color(0xff304F73);
const Color lightBlueColor = Color(0xff7095FF);

const Color errorColor = Color.fromRGBO(218, 27, 27, 1.0);
const Color brightRedColor = Color.fromRGBO(240, 67, 73, 1.0);
const Color successColor = Color.fromRGBO(37, 152, 62, 1.0);
const Color brightGreenColor = Color.fromRGBO(1, 225, 123, 1.0);

