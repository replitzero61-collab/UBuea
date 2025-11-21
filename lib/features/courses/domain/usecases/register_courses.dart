import 'package:fpdart/fpdart.dart';
import 'package:ub_t/core/error/failures.dart';
import 'package:ub_t/core/usecase_interface/usecase.dart';
import 'package:ub_t/features/courses/domain/repository/course_repository.dart';

class RegisterCourses implements UseCase<void, RegisterCoursesParams> {
  final CourseRepository repository;

  RegisterCourses(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterCoursesParams params) async {
    return await repository.registerCourses(
      studentId: params.studentId,
      courseCodes: params.courseCodes,
    );
  }
}

class RegisterCoursesParams {
  final String studentId;
  final List<String> courseCodes;

  RegisterCoursesParams({
    required this.studentId,
    required this.courseCodes,
  });
}
