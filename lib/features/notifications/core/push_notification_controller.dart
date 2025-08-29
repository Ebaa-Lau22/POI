import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:poi/features/notifications/core/firebase_push_notification_manager.dart';
import 'package:poi/features/notifications/core/local_notification_controller.dart';
import 'package:poi/features/notifications/core/notification_click_controller.dart';
import 'package:poi/features/notifications/data/models/push_notification_model.dart';

class PushNotificationController {
  static final PushNotificationController _instance =
      PushNotificationController._internal();
  factory PushNotificationController() => _instance;
  late FirebasePushNotificationManager _firebasePushNotificationManager;
  late LocalNotificationController _localNotificationController;
  bool _isInitialized = false;

  PushNotificationController._internal();

  Future<void> init() async {
    if (_isInitialized) return;
    _firebasePushNotificationManager =
        FirebasePushNotificationManager.getInstance();
    _localNotificationController = LocalNotificationController();
    _listenPushNotificationsStreams();
    _isInitialized = true;
  }

  void _listenPushNotificationsStreams() {
    _firebasePushNotificationManager.onTokenRefreshedStream.listen(
      _onFirebaseTokenRefreshed,
    );
    _firebasePushNotificationManager.onNotificationReceivedController.listen(
      _onFirebaseNotificationReceived,
    );
    _firebasePushNotificationManager.onNotificationOpenedStream.listen(
      _onFirebaseNotificationOpened,
    );
  }

  void _onFirebaseNotificationReceived(RemoteMessage message) {
    Map<String, dynamic>? messageData = message.data;
    if (messageData['payload'] != null && (messageData['payload'] is String)) {
      messageData['payload'] = jsonDecode(messageData['payload']);
    }

    _localNotificationController.showNotification(message);
  }

  void _onFirebaseTokenRefreshed(String token) {
    // _updateFcmToken(token);
  }

  void _onFirebaseNotificationOpened(PushNotificationModel notification) {
    GetIt.instance<NotificationClickController>().onClicked();
  }

  Future<String?> getFcmToken() async {
    String? token = await _firebasePushNotificationManager.getTokenFcm();
    return token;
  }
}
