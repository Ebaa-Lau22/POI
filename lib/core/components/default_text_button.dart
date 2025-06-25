import 'package:flutter/material.dart';
import 'package:poi/core/constants/constants.dart';

import '../theme/app_colors.dart';

Widget defaultTextFormField(
    context, {
      required TextEditingController controller,
      required TextInputType keyboardType,
      required Color mainColor,
      String? hintText,
      Color hintColor = Colors.grey,
      Color textColor = AppColors.mainDark,
      Widget? prefix,
      Color offColor = Colors.grey,
      Color errorColor = AppColors.lightRed,
      bool isPassword = false,
      double radiusBorder = widgetBorderRadius,
      Widget? suffix,
      void Function()? showPass,
      void Function(String)? onSubmit,
      void Function(String)? onChanged,
      String? Function(String?)? validate,
      void Function()? onTap,
      bool enabled = true,
      int? maxLength,
      int? maxLines = 1,
      int? minLines = 1,
      bool expands = false,
      bool login = false,
      Color? hintTextColor,
    }) =>
    TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      validator: validate,
      expands: expands,
      maxLines: expands == false ? maxLines : null,
      minLines: expands == false ? minLines : null,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor),
      decoration: InputDecoration(
        hintStyle: TextStyle(color: mainColor.withValues(alpha: 0.6)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: offColor, width: 1.5),
          borderRadius: BorderRadius.circular(radiusBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor, width: 1.5),
          borderRadius: BorderRadius.circular(radiusBorder),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor, width: 1.5),
          borderRadius: BorderRadius.circular(radiusBorder),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor, width: 1.5),
          borderRadius: BorderRadius.circular(radiusBorder),
        ),
        errorStyle: TextStyle(
          color: errorColor,
        ),
        hintText: hintText,
        prefixIcon: prefix,
        suffixIcon: suffix,

      ),
      onTap: onTap,

      textAlign: TextAlign.start,
      maxLength: maxLength,
    );