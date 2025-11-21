class StudySession {
  final String id;
  final String studentId;
  final String courseCode;
  final String day;
  final DateTime startTime;
  final DateTime endTime;
  final bool isCompleted;

  const StudySession({
    required this.id,
    required this.studentId,
    required this.courseCode,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
  });

  Duration get duration => endTime.difference(startTime);

  StudySession copyWith({
    String? id,
    String? studentId,
    String? courseCode,
    String? day,
    DateTime? startTime,
    DateTime? endTime,
    bool? isCompleted,
  }) {
    return StudySession(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      courseCode: courseCode ?? this.courseCode,
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
