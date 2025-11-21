import 'package:ub_t/core/common/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.courseCode,
    required super.courseName,
    required super.department,
    required super.level,
    required super.day,
    required super.startTime,
    required super.endTime,
    required super.venueName,
    super.lecturerName,
    super.credits,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      courseCode: json['course_code'] ?? '',
      courseName: json['course_name'] ?? '',
      department: json['department'] ?? '',
      level: json['level'] ?? 0,
      day: json['day'] ?? '',
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      venueName: json['venue_name'] ?? '',
      lecturerName: json['lecturer_name'],
      credits: json['credits'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_code': courseCode,
      'course_name': courseName,
      'department': department,
      'level': level,
      'day': day,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'venue_name': venueName,
      'lecturer_name': lecturerName,
      'credits': credits,
    };
  }

  Course toEntity() {
    return Course(
      courseCode: courseCode,
      courseName: courseName,
      department: department,
      level: level,
      day: day,
      startTime: startTime,
      endTime: endTime,
      venueName: venueName,
      lecturerName: lecturerName,
      credits: credits,
    );
  }
}
