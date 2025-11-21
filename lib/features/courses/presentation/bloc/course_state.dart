import 'package:equatable/equatable.dart';
import 'package:ub_t/core/common/entities/course.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object?> get props => [];
}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CoursesLoaded extends CourseState {
  final List<Course> courses;
  final List<Course> selectedCourses;
  final List<String> clashes;

  const CoursesLoaded({
    required this.courses,
    this.selectedCourses = const [],
    this.clashes = const [],
  });

  @override
  List<Object?> get props => [courses, selectedCourses, clashes];

  CourseState copyWith({
    List<Course>? courses,
    List<Course>? selectedCourses,
    List<String>? clashes,
  }) {
    return CoursesLoaded(
      courses: courses ?? this.courses,
      selectedCourses: selectedCourses ?? this.selectedCourses,
      clashes: clashes ?? this.clashes,
    );
  }
}

class StudentCoursesLoaded extends CourseState {
  final List<Course> courses;

  const StudentCoursesLoaded(this.courses);

  @override
  List<Object?> get props => [courses];
}

class CourseRegistrationSuccess extends CourseState {}

class CourseFailure extends CourseState {
  final String message;

  const CourseFailure(this.message);

  @override
  List<Object?> get props => [message];
}
