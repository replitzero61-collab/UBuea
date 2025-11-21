import 'package:flutter/material.dart';
import '../widgets/course_info_tab.dart';
import '../widgets/course_materials_tab.dart';
import '../widgets/course_tutorials_tab.dart';


import 'package:ub_t/core/common/entities/course.dart';



class CourseDetailPage extends StatelessWidget {
  final Course course;
  const CourseDetailPage({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${course.courseCode} - ${course.courseName}'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Info'),
              Tab(text: 'Materials'),
              Tab(text: 'Tutorials'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CourseInfoTab(course: course),
            CourseMaterialsTab(courseCode: course.courseCode),
            CourseTutorialsTab(courseCode: course.courseCode),
          ],
        ),
      ),
    );
  }
}
