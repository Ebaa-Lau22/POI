import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poi/core/constants/appImgaeAsset.dart';

class NoConnectionDialog extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String message;
  final double borderRadius;
  final TextStyle? textStyle;
  final double imageHeight;
  final double imageWidth;
  final EdgeInsetsGeometry contentPadding;

  const NoConnectionDialog({
    Key? key,
    required this.backgroundColor,
    required this.textColor,
    required this.message,
    this.borderRadius = 20,
    this.textStyle,
    this.imageHeight = 200,
    this.imageWidth = 200,
    this.contentPadding = const EdgeInsets.all(16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      contentPadding: contentPadding,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppImageAsset.NoConnectionImage,
            height: imageHeight,
            width: imageWidth,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style:
                textStyle ??
                TextStyle(
                  fontFamily: 'Sansation',
                  fontSize: 16,
                  color: textColor,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
