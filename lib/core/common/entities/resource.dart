class Resource {
  final String id;
  final String courseCode;
  final String title;
  final String fileUrl;
  final String type;
  final DateTime uploadedAt;
  final int? fileSize;

  const Resource({
    required this.id,
    required this.courseCode,
    required this.title,
    required this.fileUrl,
    required this.type,
    required this.uploadedAt,
    this.fileSize,
  });

  bool get isMaterial => type == 'material';
  bool get isTutorial => type == 'tutorial';

  String get fileSizeFormatted {
    if (fileSize == null) return 'Unknown size';
    final mb = fileSize! / (1024 * 1024);
    if (mb >= 1) return '${mb.toStringAsFixed(1)} MB';
    final kb = fileSize! / 1024;
    return '${kb.toStringAsFixed(0)} KB';
  }

  Resource copyWith({
    String? id,
    String? courseCode,
    String? title,
    String? fileUrl,
    String? type,
    DateTime? uploadedAt,
    int? fileSize,
  }) {
    return Resource(
      id: id ?? this.id,
      courseCode: courseCode ?? this.courseCode,
      title: title ?? this.title,
      fileUrl: fileUrl ?? this.fileUrl,
      type: type ?? this.type,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      fileSize: fileSize ?? this.fileSize,
    );
  }
}
