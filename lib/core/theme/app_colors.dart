import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color lightRed = Color(0xffB44E4E);
  static const Color darkRed = Color(0xff8C3A3A);
  static const Color lightBlue = Color(0xff728CAC);
  static const Color darkBlue = Color(0xff304F73);
  static const Color mainDark = Color(0xff2D3748);
  static const Color mainLight = Color(0xffe8e7f1);
  static const Color lighterColor = Color(0xfff1f0fa);
  static const Color darkerColor = Color(0xff1f2635);
  static const Color blackColor = Color.fromRGBO(12, 16, 27, 1.0);
  static const Color medium = Color(0xff9A9A9A);
  static const Color light = Color(0xffCDCDCD);
  static const Color white = Color(0xffffffff);

  static Color getSideColor(String side){
    if(side == "og") return lightBlue;
    if(side == "oo") return lightRed;
    if(side == "cg") return darkBlue;
    return darkRed;
  }
}

class ThemedColors {
  late Color primary;
  late Color secondary;
  late Color red;
  late Color blue;
  late Color darkerOrLighter;

  ThemedColors(bool isLightTheme){
    primary = isLightTheme ? AppColors.mainLight : AppColors.mainDark;
    secondary = isLightTheme ? AppColors.mainDark : AppColors.mainLight;
    red = isLightTheme ? AppColors.darkRed : AppColors.lightRed;
    blue = isLightTheme ? AppColors.darkBlue : AppColors.lightBlue;
    darkerOrLighter = isLightTheme ? AppColors.lighterColor : AppColors.darkerColor;
  }
}




const Color errorColor = Color.fromRGBO(218, 27, 27, 1.0);
const Color brightRedColor = Color.fromRGBO(240, 67, 73, 1.0);
const Color successColor = Color.fromRGBO(37, 152, 62, 1.0);
const Color brightGreenColor = Color.fromRGBO(1, 225, 123, 1.0);

