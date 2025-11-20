import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
  
  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }
  
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
  }
  
  static String formatDay(DateTime date) {
    return DateFormat('EEEE').format(date);
  }
  
  static String formatDayShort(DateTime date) {
    return DateFormat('EEE').format(date);
  }
  
  static DateTime parseTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
  
  static String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago';
    }
    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago';
    }
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    }
    
    return 'Just now';
  }
  
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
  
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }
  
  static String getDayOfWeek(String day) {
    switch (day.toUpperCase()) {
      case 'MON':
      case 'MONDAY':
        return 'MONDAY';
      case 'TUE':
      case 'TUESDAY':
        return 'TUESDAY';
      case 'WED':
      case 'WEDNESDAY':
        return 'WEDNESDAY';
      case 'THU':
      case 'THURSDAY':
        return 'THURSDAY';
      case 'FRI':
      case 'FRIDAY':
        return 'FRIDAY';
      case 'SAT':
      case 'SATURDAY':
        return 'SATURDAY';
      case 'SUN':
      case 'SUNDAY':
        return 'SUNDAY';
      default:
        return day.toUpperCase();
    }
  }
}
