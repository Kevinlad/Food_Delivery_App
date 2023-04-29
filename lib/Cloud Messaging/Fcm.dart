import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging message = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

// step -1 for permission
  void requestPermission() async {
    NotificationSettings settings = await message.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted the permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User access is provisional");
    } else {
      print("User Access is denied");
    }
  }

  //step -5  show Notification in android
  Future<void> showNotification(RemoteMessage message) async {
    // channel for id and name
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        "channel_id", "High Importance",
        importance: Importance.max);
    // notification details
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("Channel_id", channel.name.toString(),
            importance: Importance.high,
            icon: "@mipmap/ic_launcher",
            priority: Priority.high,
            ticker: 'ticker');
    // put the andoid notification to notification details
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    // to show the notification on the screen
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

//step - 4
  void initLocalInitialization() async {
    var androidIntialization =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initialSettings = InitializationSettings(android: androidIntialization);

    await _flutterLocalNotificationsPlugin.initialize(initialSettings,
        onDidReceiveNotificationResponse: (payload) {});
  }

// step-3  the  firebase init
  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((messaging) {
      showNotification(messaging);
      print(messaging.notification!.title.toString());
      print(messaging.notification!.body.toString());
    });
  }

// step -2 for get the token
  Future<String?> getDeviceToken() async {
    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    final FlutterLocalNotificationsPlugin _flutterNotificationPlugins =
        FlutterLocalNotificationsPlugin();

    String? token = await message.getToken();
    return token;
  }

  void getRfreshToken() async {
    message.onTokenRefresh.listen((event) {
      event.toString();
      print("Refresh token Generated");
    });
  }
}
