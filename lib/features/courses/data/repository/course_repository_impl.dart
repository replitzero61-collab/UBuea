import 'package:fpdart/fpdart.dart';
import 'package:ub_t/core/common/entities/course.dart';
import 'package:ub_t/core/error/exceptions.dart';
import 'package:ub_t/core/error/failures.dart';
import 'package:ub_t/features/courses/data/datasources/course_remote_data_source.dart';
import 'package:ub_t/features/courses/domain/repository/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource remoteDataSource;

  CourseRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Course>>> getAvailableCourses({
    required String department,
    required int level,
  }) async {
    try {
      final courseModels = await remoteDataSource.getAvailableCourses(
        department: department,
        level: level,
      );
      final courses = courseModels.map((model) => model.toEntity()).toList();
      return right(courses);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Course>>> getCarryOverCourses({
    required String department,
    required int currentLevel,
  }) async {
    try {
      final courseModels = await remoteDataSource.getCarryOverCourses(
        department: department,
        currentLevel: currentLevel,
      );
      final courses = courseModels.map((model) => model.toEntity()).toList();
      return right(courses);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Course>>> getStudentCourses(String studentId) async {
    try {
      final courseModels = await remoteDataSource.getStudentCourses(studentId);
      final courses = courseModels.map((model) => model.toEntity()).toList();
      return right(courses);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> registerCourses({
    required String studentId,
    required List<String> courseCodes,
  }) async {
    try {
      await remoteDataSource.registerCourses(
        studentId: studentId,
        courseCodes: courseCodes,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> unregisterCourse({
    required String studentId,
    required String courseCode,
  }) async {
    try {
      await remoteDataSource.unregisterCourse(
        studentId: studentId,
        courseCode: courseCode,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> toggleCourseNotifications({
    required String studentId,
    required String courseCode,
    required bool enabled,
  }) async {
    try {
      await remoteDataSource.toggleCourseNotifications(
        studentId: studentId,
        courseCode: courseCode,
        enabled: enabled,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
