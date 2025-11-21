import 'package:ub_t/core/common/entities/resource.dart';

class ResourceModel extends Resource {
  const ResourceModel({
    required super.id,
    required super.courseCode,
    required super.title,
    required super.fileUrl,
    required super.type,
    required super.uploadedAt,
    super.fileSize,
  });

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
      id: json['id'] ?? '',
      courseCode: json['course_code'] ?? '',
      title: json['title'] ?? '',
      fileUrl: json['file_url'] ?? '',
      type: json['type'] ?? 'material',
      uploadedAt: json['uploaded_at'] != null
          ? DateTime.parse(json['uploaded_at'])
          : DateTime.now(),
      fileSize: json['file_size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_code': courseCode,
      'title': title,
      'file_url': fileUrl,
      'type': type,
      'uploaded_at': uploadedAt.toIso8601String(),
      'file_size': fileSize,
    };
  }

  Resource toEntity() {
    return Resource(
      id: id,
      courseCode: courseCode,
      title: title,
      fileUrl: fileUrl,
      type: type,
      uploadedAt: uploadedAt,
      fileSize: fileSize,
    );
  }
}
