import 'package:ub_t/core/common/entities/student_course.dart';

class StudentCourseModel extends StudentCourse {
  const StudentCourseModel({
    required super.id,
    required super.studentId,
    required super.courseCode,
    required super.notificationsEnabled,
    required super.addedAt,
  });

  factory StudentCourseModel.fromJson(Map<String, dynamic> json) {
    return StudentCourseModel(
      id: json['id'] ?? '',
      studentId: json['student_id'] ?? '',
      courseCode: json['course_code'] ?? '',
      notificationsEnabled: json['notifications_enabled'] ?? true,
      addedAt: json['added_at'] != null
          ? DateTime.parse(json['added_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'course_code': courseCode,
      'notifications_enabled': notificationsEnabled,
      'added_at': addedAt.toIso8601String(),
    };
  }

  StudentCourse toEntity() {
    return StudentCourse(
      id: id,
      studentId: studentId,
      courseCode: courseCode,
      notificationsEnabled: notificationsEnabled,
      addedAt: addedAt,
    );
  }
}
