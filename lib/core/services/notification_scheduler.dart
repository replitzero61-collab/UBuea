import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'notification_service.dart';

class NotificationScheduler {
  final NotificationService _notificationService = NotificationService();

  Future<void> scheduleCourseNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    // Ensure timezone is initialized
    tz.initializeTimeZones();
    final location = tz.local;
    final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(
      scheduledTime,
      location,
    );

    final androidDetails = AndroidNotificationDetails(
      'course_channel',
      'Course Notifications',
      channelDescription: 'Notifications for course events',
      importance: Importance.max,
      priority: Priority.high,
    );
    final notificationDetails = NotificationDetails(android: androidDetails);
    await _notificationService.flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzScheduledTime,
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notificationService.flutterLocalNotificationsPlugin.cancel(id);
  }
}
