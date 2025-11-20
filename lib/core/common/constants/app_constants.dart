class AppConstants {
  static const String appName = 'UB Timetable';
  static const int splashDuration = 3;
  static const int freeTrialDays = 5;
  static const int subscriptionPriceXAF = 500;
  
  static const String currencyCode = 'XAF';
  
  static const List<int> availableLevels = [200, 300, 400, 500];
  
  static const Duration notificationBefore60Min = Duration(minutes: 60);
  static const Duration notificationBefore30Min = Duration(minutes: 30);
  static const Duration notificationBefore5Min = Duration(minutes: 5);
  static const Duration notificationBeforeEnd = Duration(minutes: -5);
  
  static const List<String> motivationalQuotes = [
    'Small changes lead to great changes... have a nice course.',
    'Success is the sum of small efforts repeated day in and day out.',
    'The expert in anything was once a beginner.',
    'Education is the passport to the future.',
    'Learning is a treasure that will follow its owner everywhere.',
  ];
  
  static const List<String> daysOfWeek = [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY',
  ];
  
  static const List<String> departments = [
    'BIOCHEMISTRY AND MOLECULAR BIOLOGY',
    'BOTANY AND PLANT PHYSIOLOGY',
    'CHEMISTRY',
    'COMPUTER SCIENCE',
    'ENVIRONMENTAL SCIENCE',
    'GEOLOGY',
    'MATHEMATICS',
    'MICROBIOLOGY',
    'PHYSICS',
    'ZOOLOGY',
    'COMPUTER ENGINEERING',
    'ELECTRICAL AND ELECTRONIC ENGINEERING',
    'MECHANICAL ENGINEERING',
    'RENEWABLE ENERGY',
  ];
  
  static const int maxStudyHoursPerDay = 12;
  static const int minSleepHours = 4;
  static const Duration defaultCommuteBuffer = Duration(hours: 1);
}
