import 'package:equatable/equatable.dart';

abstract class ResourceEvent extends Equatable {
  const ResourceEvent();
  @override
  List<Object?> get props => [];
}

class LoadResourcesByCourse extends ResourceEvent {
  final String courseCode;
  const LoadResourcesByCourse(this.courseCode);
  @override
  List<Object?> get props => [courseCode];
}

class LoadResourceById extends ResourceEvent {
  final String resourceId;
  const LoadResourceById(this.resourceId);
  @override
  List<Object?> get props => [resourceId];
}
