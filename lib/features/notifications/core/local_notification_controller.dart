import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:poi/features/notifications/core/notification_click_controller.dart';

class LocalNotificationController {
  LocalNotificationController._internal() {
    _init();
  }
  static final LocalNotificationController _instance =
      LocalNotificationController._internal();
  factory LocalNotificationController() {
    return _instance;
  }
  static const String notificationIcon = "@mipmap/ic_launcher";
  late AndroidNotificationChannel _channel;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificaionsPlugin;
  Future<void> _init() async {
    _flutterLocalNotificaionsPlugin = FlutterLocalNotificationsPlugin();
    _channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: "This channel is used for important notifications.",
      importance: Importance.high,
      showBadge: true,
    );
    await _flutterLocalNotificaionsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);
    const initializationSettingsAndroid = AndroidInitializationSettings(
      notificationIcon,
    );
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await _flutterLocalNotificaionsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationOpened,
    );
  }

  void _onNotificationOpened(NotificationResponse notificationResponse) async {
    debugPrint("From local notification Controller");
    GetIt.instance<NotificationClickController>().onClicked();
  }

  void showNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;
    if (notification != null &&
        ((android != null && Platform.isAndroid) ||
            (apple != null && Platform.isIOS))) {
      _flutterLocalNotificaionsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: Importance.high,
            priority: Priority.high,
            icon: notificationIcon,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  Future<void> cancelAllNotification() async {
    _flutterLocalNotificaionsPlugin.cancelAll();
  }
}
