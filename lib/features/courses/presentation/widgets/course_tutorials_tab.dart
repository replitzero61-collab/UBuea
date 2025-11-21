import 'package:flutter/material.dart';

class CourseTutorialsTab extends StatelessWidget {
  final String courseCode;
  const CourseTutorialsTab({Key? key, required this.courseCode})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual tutorials from backend
    final List<Map<String, String>> tutorials = [
      {'title': 'Past Question 2023', 'url': '#'},
      {'title': 'Past Question 2022', 'url': '#'},
    ];
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: tutorials.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final tutorial = tutorials[index];
        return ListTile(
          leading: const Icon(Icons.picture_as_pdf),
          title: Text(tutorial['title']!),
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
