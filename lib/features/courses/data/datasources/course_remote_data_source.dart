import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ub_t/core/common/models/course_model.dart';
import 'package:ub_t/core/error/exceptions.dart';

abstract interface class CourseRemoteDataSource {
  Future<List<CourseModel>> getAvailableCourses({
    required String department,
    required int level,
  });

  Future<List<CourseModel>> getCarryOverCourses({
    required String department,
    required int currentLevel,
  });

  Future<List<CourseModel>> getStudentCourses(String studentId);

  Future<void> registerCourses({
    required String studentId,
    required List<String> courseCodes,
  });

  Future<void> unregisterCourse({
    required String studentId,
    required String courseCode,
  });

  Future<void> toggleCourseNotifications({
    required String studentId,
    required String courseCode,
    required bool enabled,
  });
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final SupabaseClient supabaseClient;

  CourseRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<CourseModel>> getAvailableCourses({
    required String department,
    required int level,
  }) async {
    try {
      final response = await supabaseClient
          .from('master_timetable')
          .select()
          .eq('department', department)
          .lte('level', level)
          .order('level', ascending: false);

      return (response as List)
          .map((course) => CourseModel.fromJson(course))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CourseModel>> getCarryOverCourses({
    required String department,
    required int currentLevel,
  }) async {
    try {
      final response = await supabaseClient
          .from('master_timetable')
          .select()
          .eq('department', department)
          .lt('level', currentLevel);

      return (response as List)
          .map((course) => CourseModel.fromJson(course))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CourseModel>> getStudentCourses(String studentId) async {
    try {
      final response = await supabaseClient
          .from('student_courses')
          .select('course_code')
          .eq('student_id', studentId);

      final courseCodes = (response as List)
          .map((item) => item['course_code'] as String)
          .toList();

      if (courseCodes.isEmpty) {
        return [];
      }

      final coursesResponse = await supabaseClient
          .from('master_timetable')
          .select()
          .inFilter('course_code', courseCodes);

      return (coursesResponse as List)
          .map((course) => CourseModel.fromJson(course))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> registerCourses({
    required String studentId,
    required List<String> courseCodes,
  }) async {
    try {
      final records = courseCodes.map((code) => {
        'student_id': studentId,
        'course_code': code,
        'notifications_enabled': true,
        'added_at': DateTime.now().toIso8601String(),
      }).toList();

      await supabaseClient.from('student_courses').insert(records);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> unregisterCourse({
    required String studentId,
    required String courseCode,
  }) async {
    try {
      await supabaseClient
          .from('student_courses')
          .delete()
          .eq('student_id', studentId)
          .eq('course_code', courseCode);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> toggleCourseNotifications({
    required String studentId,
    required String courseCode,
    required bool enabled,
  }) async {
    try {
      await supabaseClient
          .from('student_courses')
          .update({'notifications_enabled': enabled})
          .eq('student_id', studentId)
          .eq('course_code', courseCode);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
