// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/*class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );
    await notificationsPlugin.initialize(settings);
  }

  static Future showNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'workout_channel',
          'Workout Reminder',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await notificationsPlugin.show(
      id: 0,

      payload: "Workout Reminder",
      body: "Time to start your workout 💪",
      notificationDetails: details,
    );
  }
}*/
