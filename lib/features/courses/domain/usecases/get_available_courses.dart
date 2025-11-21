import 'package:fpdart/fpdart.dart';
import 'package:ub_t/core/common/entities/course.dart';
import 'package:ub_t/core/error/failures.dart';
import 'package:ub_t/core/usecase_interface/usecase.dart';
import 'package:ub_t/features/courses/domain/repository/course_repository.dart';

class GetAvailableCourses implements UseCase<List<Course>, GetAvailableCoursesParams> {
  final CourseRepository repository;

  GetAvailableCourses(this.repository);

  @override
  Future<Either<Failure, List<Course>>> call(GetAvailableCoursesParams params) async {
    return await repository.getAvailableCourses(
      department: params.department,
      level: params.level,
    );
  }
}

class GetAvailableCoursesParams {
  final String department;
  final int level;

  GetAvailableCoursesParams({
    required this.department,
    required this.level,
  });
}
