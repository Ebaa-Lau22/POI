import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:poi/features/notifications/data/enums/notification_type.dart';
import 'package:poi/features/notifications/data/models/push_notification_model.dart';

initFirebaseMessagingServices() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("_onFirebaseBackgroundMessage() ${message.data}");
}

class FirebasePushNotificationManager {
  static FirebasePushNotificationManager? _instance;
  FirebasePushNotificationManager._internal() {
    intialize();
  }
  static FirebasePushNotificationManager getInstance() {
    return _instance ??= FirebasePushNotificationManager._internal();
  }

  final _messaging = FirebaseMessaging.instance;
  // On Notification Received Stream
  final StreamController<RemoteMessage> _onNotificationReceivedController =
      StreamController.broadcast();
  Stream<RemoteMessage> get onNotificationReceivedController =>
      _onNotificationReceivedController.stream;
  // On Token refresh Stream
  final StreamController<String> _onTokenRefreshedController =
      StreamController.broadcast();
  Stream<String> get onTokenRefreshedStream =>
      _onTokenRefreshedController.stream;
  // On Notification Opened Stream
  final StreamController<PushNotificationModel>
  _onNotificationOpenedController = StreamController<PushNotificationModel>();
  Stream<PushNotificationModel> get onNotificationOpenedStream =>
      _onNotificationOpenedController.stream;
  Future<void> intialize() async {
    await _requestPermission();
    await _setupMessageHandlers();
    await getFcmToken();
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );
    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        return;
      case AuthorizationStatus.denied:
        return;
      case AuthorizationStatus.notDetermined:
        return;
      case AuthorizationStatus.provisional:
        return;
    }
  }

  Future<void> getFcmToken() async {
    final fcmToken = await _messaging.getToken();
    debugPrint("fcmToken : $fcmToken");
    if (fcmToken != null) {
      _onTokenRefreshed(fcmToken);
    }
  }

  Future<void> _setupMessageHandlers() async {
    _messaging.onTokenRefresh.listen(_onTokenRefreshed);
    FirebaseMessaging.onMessage.listen(_onFirebaseMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _onMessageOpenedApp(initialMessage);
    }
  }

  void _onMessageOpenedApp(RemoteMessage message) {
    debugPrint("_onMessageOpenedApp : ${message.data}");
    Map<String, dynamic>? messageData;
    messageData = message.data;
    if (messageData['payload'] != null) {
      messageData['payload'] = jsonDecode(messageData['payload']);
    }
    _onNotificationOpenedController.sink.add(PushNotificationModel());
  }

  void _onFirebaseMessage(RemoteMessage message) {
    debugPrint("_onFirebaseMessage: ${message.data}");
    _onNotificationReceivedController.sink.add(message);
  }

  void _onTokenRefreshed(String token) {
    debugPrint("_onTokenRefreshed : $token");
    _onTokenRefreshedController.sink.add(token);
  }

  Future<void> sendToken() async {
    String? token = await _messaging.getToken();
    if (token != null) {
      _onTokenRefreshed(token);
    }
  }

  Future<String?> getTokenFcm() async {
    try {
      String? token = await _messaging.getToken();
      return token;
    } catch (err) {
      debugPrint("[FirebasePushNotificationManager] getTokenFcm Error : $err");
      return null;
    }
  }

  Future<NotificationSettings> getNotificationSettings() async {
    return await _messaging.getNotificationSettings();
  }
}
