import 'package:flutter/material.dart';

class CustomMuteIndicator extends StatelessWidget {
  final Color iconColor;
  final Color backgroundColor;
  final double iconSize;

  const CustomMuteIndicator({
    super.key,
    required this.iconColor,
    this.backgroundColor = Colors.black26,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.3),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: iconColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.all(4),
        child: Icon(
          Icons.mic_off_outlined,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
