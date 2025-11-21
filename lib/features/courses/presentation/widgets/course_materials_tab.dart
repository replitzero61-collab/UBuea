import 'package:flutter/material.dart';

class CourseMaterialsTab extends StatelessWidget {
  final String courseCode;
  const CourseMaterialsTab({Key? key, required this.courseCode})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual materials from backend
    final List<Map<String, String>> materials = [
      {'title': 'Lecture Notes 1', 'url': '#'},
      {'title': 'Lecture Notes 2', 'url': '#'},
    ];
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: materials.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final material = materials[index];
        return ListTile(
          leading: const Icon(Icons.picture_as_pdf),
          title: Text(material['title']!),
          trailing: IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // TODO: Implement download
            },
          ),
        );
      },
    );
  }
}
