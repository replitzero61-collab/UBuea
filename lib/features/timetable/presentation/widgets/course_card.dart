import 'package:flutter/material.dart';
import 'package:ub_t/core/common/entities/course.dart';
import 'package:ub_t/features/courses/presentation/pages/course_detail_page.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time =
        '${course.startTime.hour.toString().padLeft(2, '0')}:${course.startTime.minute.toString().padLeft(2, '0')} - '
        '${course.endTime.hour.toString().padLeft(2, '0')}:${course.endTime.minute.toString().padLeft(2, '0')}';
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          course.courseCode,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Time: $time'),
            Text('Venue: ${course.venueName}'),
            if (course.lecturerName != null)
              Text('Lecturer: ${course.lecturerName}'),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => CourseDetailPage(course: course)),
          );
        },
      ),
    );
  }
}
