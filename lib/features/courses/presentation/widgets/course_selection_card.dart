import 'package:flutter/material.dart';

class CourseSelectionCard extends StatelessWidget {
  final String courseCode;
  final String courseName;
  final bool isSelected;
  final bool clash;
  final ValueChanged<bool> onChanged;

  const CourseSelectionCard({
    Key? key,
    required this.courseCode,
    required this.courseName,
    required this.isSelected,
    required this.onChanged,
    this.clash = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: clash ? Colors.red[50] : null,
      child: ListTile(
        leading: Checkbox(
          value: isSelected,
          onChanged: (val) => onChanged(val ?? false),
        ),
        title: Text('$courseCode - $courseName'),
        trailing: clash ? const Icon(Icons.warning, color: Colors.red) : null,
      ),
    );
  }
}
