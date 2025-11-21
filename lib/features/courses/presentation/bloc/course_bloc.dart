import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ub_t/core/common/entities/course.dart';
import 'package:ub_t/features/courses/domain/usecases/get_available_courses.dart';
import 'package:ub_t/features/courses/domain/usecases/get_student_courses.dart';
import 'package:ub_t/features/courses/domain/usecases/register_courses.dart';
import 'package:ub_t/features/courses/presentation/bloc/course_event.dart';
import 'package:ub_t/features/courses/presentation/bloc/course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetAvailableCourses _getAvailableCourses;
  final GetStudentCourses _getStudentCourses;
  final RegisterCourses _registerCourses;

  CourseBloc({
    required GetAvailableCourses getAvailableCourses,
    required GetStudentCourses getStudentCourses,
    required RegisterCourses registerCourses,
  })  : _getAvailableCourses = getAvailableCourses,
        _getStudentCourses = getStudentCourses,
        _registerCourses = registerCourses,
        super(CourseInitial()) {
    on<LoadAvailableCourses>(_onLoadAvailableCourses);
    on<ToggleCourseSelection>(_onToggleCourseSelection);
    on<RegisterSelectedCourses>(_onRegisterSelectedCourses);
    on<LoadStudentCourses>(_onLoadStudentCourses);
  }

  void _onLoadAvailableCourses(
    LoadAvailableCourses event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());

    final result = await _getAvailableCourses(
      GetAvailableCoursesParams(
        department: event.department,
        level: event.level,
      ),
    );

    result.fold(
      (failure) => emit(CourseFailure(failure.message)),
      (courses) {
        final clashes = _detectClashes([]);
        emit(CoursesLoaded(courses: courses, clashes: clashes));
      },
    );
  }

  void _onToggleCourseSelection(
    ToggleCourseSelection event,
    Emitter<CourseState> emit,
  ) {
    if (state is CoursesLoaded) {
      final currentState = state as CoursesLoaded;
      final courses = currentState.courses;
      final selectedCourses = List<Course>.from(currentState.selectedCourses);

      final courseIndex = selectedCourses.indexWhere(
        (c) => c.courseCode == event.courseCode,
      );

      if (courseIndex >= 0) {
        selectedCourses.removeAt(courseIndex);
      } else {
        final course = courses.firstWhere(
          (c) => c.courseCode == event.courseCode,
        );
        selectedCourses.add(course);
      }

      final clashes = _detectClashes(selectedCourses);

      emit(CoursesLoaded(
        courses: courses,
        selectedCourses: selectedCourses,
        clashes: clashes,
      ));
    }
  }

  void _onRegisterSelectedCourses(
    RegisterSelectedCourses event,
    Emitter<CourseState> emit,
  ) async {
    if (state is CoursesLoaded) {
      final currentState = state as CoursesLoaded;
      
      if (currentState.selectedCourses.isEmpty) {
        emit(const CourseFailure('Please select at least one course'));
        return;
      }

      final courseCodes = currentState.selectedCourses
          .map((course) => course.courseCode)
          .toList();

      final clashes = _detectClashes(currentState.selectedCourses);

      emit(CourseLoading());

      final result = await _registerCourses(
        RegisterCoursesParams(
          studentId: event.studentId,
          courseCodes: courseCodes,
        ),
      );

      result.fold(
        (failure) => emit(CourseFailure(failure.message)),
        (_) => emit(CourseRegistrationSuccess()),
      );
    }
  }

  void _onLoadStudentCourses(
    LoadStudentCourses event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());

    final result = await _getStudentCourses(event.studentId);

    result.fold(
      (failure) => emit(CourseFailure(failure.message)),
      (courses) => emit(StudentCoursesLoaded(courses)),
    );
  }

  List<String> _detectClashes(List<Course> courses) {
    final clashes = <String>[];

    for (int i = 0; i < courses.length; i++) {
      for (int j = i + 1; j < courses.length; j++) {
        if (courses[i].clashesWith(courses[j])) {
          clashes.add('${courses[i].courseCode} clashes with ${courses[j].courseCode}');
        }
      }
    }

    return clashes;
  }
}
