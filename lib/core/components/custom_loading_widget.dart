import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poi/core/theme/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;
  final Color secondRingColor;
  final Color thirdRingColor;

  const CustomLoadingIndicator({
    Key? key,
    required this.size,
    required this.color,
    required this.secondRingColor,
    required this.thirdRingColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.discreteCircle(
      color: color,
      secondRingColor: secondRingColor,
      thirdRingColor: thirdRingColor,
      size: size,
    );
  }
}
