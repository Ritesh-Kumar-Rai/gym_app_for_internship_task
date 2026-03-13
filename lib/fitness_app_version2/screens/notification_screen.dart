import "package:flutter/material.dart";

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  /*Future<void> initNotification() async {
    // Android-specific settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS-specific settings
    // const DarwinInitializationSettings initializationSettingsIOS =
    //     DarwinInitializationSettings(
    //       requestAlertPermission: true,
    //       requestBadgePermission: true,
    //       requestSoundPermission: true,
    //     );

    // const InitializationSettings initializationSettings =
    //     InitializationSettings(
    //       android: initializationSettingsAndroid,
    //       // iOS: initializationSettingsIOS,
    //     );

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // await flutterLocalNotificationsPlugin.initialize(
    //   settings: initializationSettings,
    // );

    FlutterLocalNotificationsPlugin().initialize(
      settings: initializationSettings,
    );
  }*/

  Future<void> initNotification() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    await notificationsPlugin.initialize(settings: initializationSettings);

    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();

    // Initialize notifications when screen starts
    notificationService.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification Screen")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notificationService.showNotification(
            id: 90,
            title: "Fitness Gym Tracker",
            body: "You have an notification 😉",
          );
          print("Notification button is presssed!!!");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
