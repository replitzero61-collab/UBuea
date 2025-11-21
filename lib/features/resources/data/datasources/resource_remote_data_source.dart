import 'package:ub_t/core/common/entities/resource.dart';

abstract class ResourceRemoteDataSource {
  Future<List<Resource>> getResourcesByCourse(String courseCode);
  Future<Resource> getResourceById(String id);
}

class ResourceRemoteDataSourceImpl implements ResourceRemoteDataSource {
  @override
  Future<List<Resource>> getResourcesByCourse(String courseCode) async {
    // TODO: Connect to Supabase or API to fetch resources for a course
    return [];
  }

  @override
  Future<Resource> getResourceById(String id) async {
    // TODO: Fetch resource details by id
    throw UnimplementedError();
  }
}
