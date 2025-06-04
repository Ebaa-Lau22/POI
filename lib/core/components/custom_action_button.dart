import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CircularActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;
  final Color bgColor;

  const CircularActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      color: bgColor,
      child: IconButton(
        icon: Icon(
          icon,
          color: iconColor,
        ),
        onPressed: onPressed,
        splashRadius: 24,
      ),
    );
  }
}
