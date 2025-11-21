import 'package:equatable/equatable.dart';
import 'package:ub_t/core/common/entities/resource.dart';

abstract class ResourceState extends Equatable {
  const ResourceState();
  @override
  List<Object?> get props => [];
}

class ResourceInitial extends ResourceState {}

class ResourceLoading extends ResourceState {}

class ResourcesLoaded extends ResourceState {
  final List<Resource> resources;
  const ResourcesLoaded(this.resources);
  @override
  List<Object?> get props => [resources];
}

class ResourceLoaded extends ResourceState {
  final Resource resource;
  const ResourceLoaded(this.resource);
  @override
  List<Object?> get props => [resource];
}

class ResourceError extends ResourceState {
  final String message;
  const ResourceError(this.message);
  @override
  List<Object?> get props => [message];
}
