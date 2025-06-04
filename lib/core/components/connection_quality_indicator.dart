import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:poi/core/localization/l10n/context_localiztion.dart';

import '../theme/app_colors.dart';

class ConnectionQualityIndicator extends StatelessWidget {
  final ConnectionQuality quality;

  const ConnectionQualityIndicator({super.key, required this.quality});

  Color _getColor() {
    switch (quality) {
      case ConnectionQuality.excellent:
        return successColor;
      case ConnectionQuality.good:
        return Colors.yellow;
      case ConnectionQuality.poor:
        return errorColor;
      case ConnectionQuality.unknown:
      default:
        return Colors.grey;
    }
  }

  IconData _getIcon() {
    switch (quality) {
      case ConnectionQuality.excellent:
        return Icons.wifi;
      case ConnectionQuality.good:
        return Icons.wifi_2_bar;
      case ConnectionQuality.poor:
        return Icons.wifi_1_bar;
      case ConnectionQuality.unknown:
      default:
        return Icons.wifi_off;
    }
  }

  String _getName(BuildContext context) {
    switch (quality) {
      case ConnectionQuality.excellent:
        return context.loc.excellent;
      case ConnectionQuality.good:
        return context.loc.good;
      case ConnectionQuality.poor:
        return context.loc.poor;
      case ConnectionQuality.unknown:
      default:
        return context.loc.unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, 1.0),
          child: Icon(_getIcon(), color: _getColor(), size: 24),
        ),
        Text(
          _getName(context),
          style: TextStyle(color: _getColor(), fontSize: 9),
        ),
      ],
    );
  }
}
