import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationManager() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initNotifications();
  }

  getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }

  void initNotifications() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void showNotificationDaily(
      int id, String title, String body, int hour, int minute) async {
    final tz = await _initializeTimeZones();
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      getPlatformChannelSpecfics(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    print('Notification Succesfully Scheduled at ${scheduledDate.toString()}');
  }

  Future<dynamic> _initializeTimeZones() async {
    // Placeholder for timezone initialization
    return Future.value(null);
  }

  getPlatformChannelSpecfics() {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'medicine_reminder_channel', 'Medicine Reminders',
        channelDescription: 'Medicine reminder notifications',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'Medicine Reminder');
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    return platformChannelSpecifics;
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {
    print('Notification clicked');
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    return Future.value(1);
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
