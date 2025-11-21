import 'package:equatable/equatable.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class LoadAvailableCourses extends CourseEvent {
  final String department;
  final int level;
  final bool includeCarryOvers;

  const LoadAvailableCourses({
    required this.department,
    required this.level,
    this.includeCarryOvers = false,
  });

  @override
  List<Object?> get props => [department, level, includeCarryOvers];
}

class ToggleCourseSelection extends CourseEvent {
  final String courseCode;

  const ToggleCourseSelection(this.courseCode);

  @override
  List<Object?> get props => [courseCode];
}

class RegisterSelectedCourses extends CourseEvent {
  final String studentId;

  const RegisterSelectedCourses(this.studentId);

  @override
  List<Object?> get props => [studentId];
}

class LoadStudentCourses extends CourseEvent {
  final String studentId;

  const LoadStudentCourses(this.studentId);

  @override
  List<Object?> get props => [studentId];
}

class UnregisterCourse extends CourseEvent {
  final String studentId;
  final String courseCode;

  const UnregisterCourse({
    required this.studentId,
    required this.courseCode,
  });

  @override
  List<Object?> get props => [studentId, courseCode];
}
