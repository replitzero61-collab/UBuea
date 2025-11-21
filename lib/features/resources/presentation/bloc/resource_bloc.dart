import 'package:flutter_bloc/flutter_bloc.dart';
import 'resource_event.dart';
import 'resource_state.dart';
import '../../domain/usecases/get_resources_by_course.dart';
import '../../domain/usecases/get_resource_by_id.dart';

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final GetResourcesByCourse getResourcesByCourse;
  final GetResourceById getResourceById;
  ResourceBloc({
    required this.getResourcesByCourse,
    required this.getResourceById,
  }) : super(ResourceInitial()) {
    on<LoadResourcesByCourse>((event, emit) async {
      emit(ResourceLoading());
      try {
        final resources = await getResourcesByCourse(event.courseCode);
        emit(ResourcesLoaded(resources));
      } catch (e) {
        emit(ResourceError('Failed to load resources'));
      }
    });
    on<LoadResourceById>((event, emit) async {
      emit(ResourceLoading());
      try {
        final resource = await getResourceById(event.resourceId);
        emit(ResourceLoaded(resource));
      } catch (e) {
        emit(ResourceError('Failed to load resource'));
      }
    });
  }
}
