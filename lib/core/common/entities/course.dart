class Course {
  final String courseCode;
  final String courseName;
  final String department;
  final int level;
  final String day;
  final DateTime startTime;
  final DateTime endTime;
  final String venueName;
  final String? lecturerName;
  final int? credits;

  const Course({
    required this.courseCode,
    required this.courseName,
    required this.department,
    required this.level,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.venueName,
    this.lecturerName,
    this.credits,
  });

  bool clashesWith(Course other) {
    if (day != other.day) return false;
    
    return (startTime.isBefore(other.endTime) && endTime.isAfter(other.startTime));
  }

  Duration get duration => endTime.difference(startTime);

  Course copyWith({
    String? courseCode,
    String? courseName,
    String? department,
    int? level,
    String? day,
    DateTime? startTime,
    DateTime? endTime,
    String? venueName,
    String? lecturerName,
    int? credits,
  }) {
    return Course(
      courseCode: courseCode ?? this.courseCode,
      courseName: courseName ?? this.courseName,
      department: department ?? this.department,
      level: level ?? this.level,
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      venueName: venueName ?? this.venueName,
      lecturerName: lecturerName ?? this.lecturerName,
      credits: credits ?? this.credits,
    );
  }
}
