import 'package:fpdart/fpdart.dart';
import 'package:ub_t/core/common/entities/course.dart';
import 'package:ub_t/core/error/failures.dart';
import 'package:ub_t/core/usecase_interface/usecase.dart';
import 'package:ub_t/features/courses/domain/repository/course_repository.dart';

class GetStudentCourses implements UseCase<List<Course>, String> {
  final CourseRepository repository;

  GetStudentCourses(this.repository);

  @override
  Future<Either<Failure, List<Course>>> call(String studentId) async {
    return await repository.getStudentCourses(studentId);
  }
}
