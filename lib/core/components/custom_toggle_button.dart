import 'package:flutter/material.dart';
import 'package:poi/core/theme/app_colors.dart';

class ToggleCircleButton extends StatelessWidget {
  final bool isEnabled;
  final IconData enabledIcon;
  final IconData disabledIcon;
  final bool isLightTheme;
  final VoidCallback onPressed;

  const ToggleCircleButton({
    super.key,
    required this.isEnabled,
    required this.enabledIcon,
    required this.disabledIcon,
    required this.onPressed,
    required this.isLightTheme,
  });

  @override
  Widget build(BuildContext context) {
    ThemedColors c = ThemedColors(isLightTheme);
    return Material(
      shape: const CircleBorder(),
      color: isEnabled ? c.secondary : c.primary,
      child: IconButton(
        icon: Icon(
          isEnabled ? enabledIcon : disabledIcon,
          color: isEnabled ? c.primary : AppColors.lightRed,
        ),
        onPressed: onPressed,
        splashRadius: 24,
      ),
    );
  }
}
