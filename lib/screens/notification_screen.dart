import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// for scheduling we require timezone package
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

  // init method for scheduled notifications.
  Future<void> initTimeZone() async {
    tz.initializeTimeZones();
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestExactAlarmsPermission();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    print("Current tz.local: ${tz.TZDateTime.now(tz.local)}");
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

  Future<void> scheduleNotification(
    BuildContext context, {
    int passedMinute = 0,
  }) async {
    final duration = (passedMinute > 0)
        ? Duration(minutes: passedMinute)
        : Duration(seconds: 20);

    final schedule = tz.TZDateTime.now(tz.local).add(duration);

    try {
      await notificationsPlugin.zonedSchedule(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        title: "Scheduled Notification",
        body: "This should fire exactly",
        scheduledDate: schedule,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            "test_channel",
            "Test Notifications",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
      print("🍀 no error!");
    } on PlatformException catch (e) {
      if (e.code == 'exact_alarms_not_permitted') {
        print("😩 platform specific error $e");
        await notificationsPlugin.zonedSchedule(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          title: "Scheduled Notification",
          body: "Fallback to inexact",
          scheduledDate: schedule,
          notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails(
              "test_channel",
              "Test Notifications",
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.inexact,
        );
      }
    }
    final message = (passedMinute > 0)
        ? "Reminder set for $passedMinute minutes"
        : "Default Reminder set for 20 seconds";
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
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
    notificationService.initTimeZone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification Screen")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => notificationService.showNotification(
            id: 20,
            title: "Fitness Gym Tracker",
            body: "You have an notification 😉",
          ),
          child: Text("Show Notification"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await askNotificationMinutes(context, notificationService);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// modal for notification scheduling
Future<int?> askNotificationMinutes(
  BuildContext parentContext,
  NotificationService instance,
) async {
  final controller = TextEditingController();

  return await showDialog<int>(
    context: parentContext,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text("Reminder ⏰"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Minutes",
            hintText: "Enter minutes (e.g. 30)",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final minutes = int.tryParse(controller.text);
              Navigator.pop(dialogContext);
              if (minutes != null) {
                (minutes > 0)
                    ? await instance.scheduleNotification(
                        parentContext,
                        passedMinute: minutes,
                      )
                    : await instance.scheduleNotification(parentContext);
              } else {
                await instance.scheduleNotification(parentContext);
              }
            },
            child: const Text("Set"),
          ),
        ],
      );
    },
  );
}
