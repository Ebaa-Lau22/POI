import 'package:flutter/material.dart';

class NotificationClickController {
  NotificationClickController();
  void onClicked({
    int? notificationId,
    bool? isRead,
    VoidCallback? onReadSuccess,
  }) {
    handleNotificationClick();
  }

  Future<void> handleNotificationClick() async {}
}
