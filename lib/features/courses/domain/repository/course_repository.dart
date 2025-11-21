import 'package:fpdart/fpdart.dart';
import 'package:ub_t/core/common/entities/course.dart';
import 'package:ub_t/core/error/failures.dart';

abstract interface class CourseRepository {
  Future<Either<Failure, List<Course>>> getAvailableCourses({
    required String department,
    required int level,
  });

  Future<Either<Failure, List<Course>>> getCarryOverCourses({
    required String department,
    required int currentLevel,
  });

  Future<Either<Failure, List<Course>>> getStudentCourses(String studentId);

  Future<Either<Failure, void>> registerCourses({
    required String studentId,
    required List<String> courseCodes,
  });

  Future<Either<Failure, void>> unregisterCourse({
    required String studentId,
    required String courseCode,
  });

  Future<Either<Failure, void>> toggleCourseNotifications({
    required String studentId,
    required String courseCode,
    required bool enabled,
  });
}
