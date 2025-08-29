import 'dart:ui';

import 'package:poi/core/theme/app_colors.dart';

enum NotificationType { important, moderate, normal }

extension NotificationColor on NotificationType {
  Color get color {
    switch (this) {
      case NotificationType.important:
        return AppColors.darkRed;
      case NotificationType.moderate:
        return AppColors.lightRed;
      case NotificationType.normal:
        return AppColors.lightBlue;
    }
  }
}

extension NotificationTypeJson on NotificationType {
  String toJson() {
    switch (this) {
      case NotificationType.important:
        return 'important';
      case NotificationType.moderate:
        return 'moderate';
      case NotificationType.normal:
        return 'normal';
    }
  }

  static NotificationType fromJson(String json) {
    switch (json.toLowerCase()) {
      case 'important':
        return NotificationType.important;
      case 'moderate':
        return NotificationType.moderate;
      case 'normal':
        return NotificationType.normal;
      default:
        throw ArgumentError('Unknown notification type: $json');
    }
  }
}
