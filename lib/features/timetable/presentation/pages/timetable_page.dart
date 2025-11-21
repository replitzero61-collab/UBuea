import 'package:flutter/material.dart';
import '../widgets/timetable_calendar.dart';

class TimetablePage extends StatelessWidget {
  const TimetablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Timetable')),
      body: const TimetableCalendar(),
    );
  }
}
