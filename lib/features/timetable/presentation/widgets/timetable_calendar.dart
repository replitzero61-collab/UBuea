import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:ub_t/core/common/entities/course.dart';
import 'course_card.dart';

class TimetableCalendar extends StatefulWidget {
  const TimetableCalendar({Key? key}) : super(key: key);

  @override
  State<TimetableCalendar> createState() => _TimetableCalendarState();
}

class _TimetableCalendarState extends State<TimetableCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // TODO: Replace with actual course data from BLoC
  final Map<DateTime, List<Course>> _mockCourses = {
    DateTime.utc(2025, 11, 24): [
      Course(
        courseCode: 'MET304',
        courseName: 'Metallurgy',
        department: 'Engineering',
        level: 300,
        day: 'MONDAY',
        startTime: DateTime.utc(2025, 11, 24, 8, 0),
        endTime: DateTime.utc(2025, 11, 24, 10, 0),
        venueName: 'AMPHI 150',
        lecturerName: 'Dr. Fomum',
        credits: 3,
      ),
    ],
    DateTime.utc(2025, 11, 25): [
      Course(
        courseCode: 'CSC201',
        courseName: 'Computer Science',
        department: 'Science',
        level: 200,
        day: 'TUESDAY',
        startTime: DateTime.utc(2025, 11, 25, 10, 0),
        endTime: DateTime.utc(2025, 11, 25, 12, 0),
        venueName: 'CLBK II',
        lecturerName: 'Prof. Neba',
        credits: 4,
      ),
    ],
  };

  List<Course> _getCoursesForDay(DateTime day) {
    return _mockCourses[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final courses = _getCoursesForDay(_selectedDay ?? _focusedDay);
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2025, 1, 1),
          lastDay: DateTime.utc(2026, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarFormat: CalendarFormat.week,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: courses.isEmpty
              ? const Center(child: Text('No courses for this day'))
              : ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return CourseCard(course: course);
                  },
                ),
        ),
      ],
    );
  }
}
