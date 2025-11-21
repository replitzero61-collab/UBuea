class StudentCourse {
  final String id;
  final String studentId;
  final String courseCode;
  final bool notificationsEnabled;
  final DateTime addedAt;

  const StudentCourse({
    required this.id,
    required this.studentId,
    required this.courseCode,
    required this.notificationsEnabled,
    required this.addedAt,
  });

  StudentCourse copyWith({
    String? id,
    String? studentId,
    String? courseCode,
    bool? notificationsEnabled,
    DateTime? addedAt,
  }) {
    return StudentCourse(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      courseCode: courseCode ?? this.courseCode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
