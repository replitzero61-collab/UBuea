import 'package:flutter/material.dart';
import 'package:ub_t/core/common/entities/course.dart';

class CourseInfoTab extends StatelessWidget {
  final Course course;
  const CourseInfoTab({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time =
        '${course.startTime.hour.toString().padLeft(2, '0')}:${course.startTime.minute.toString().padLeft(2, '0')} - '
        '${course.endTime.hour.toString().padLeft(2, '0')}:${course.endTime.minute.toString().padLeft(2, '0')}';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Course Code: ${course.courseCode}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text('Course Name: ${course.courseName}'),
          const SizedBox(height: 8),
          if (course.lecturerName != null)
            Text('Lecturer: ${course.lecturerName}'),
          const SizedBox(height: 8),
          Text('Venue: ${course.venueName}'),
          const SizedBox(height: 8),
          Text('Time: $time'),
          const SizedBox(height: 8),
          if (course.credits != null) Text('Credits: ${course.credits}'),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Notifications:'),
              Switch(
                value: true, // TODO: Bind to actual notification state
                onChanged: (val) {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement share functionality
            },
            icon: const Icon(Icons.share),
            label: const Text('Share Course Info'),
          ),
        ],
      ),
    );
  }
}
