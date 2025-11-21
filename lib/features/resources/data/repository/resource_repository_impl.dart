import 'package:ub_t/core/common/entities/resource.dart';
import '../../domain/repository/resource_repository.dart';
import '../datasources/resource_remote_data_source.dart';

class ResourceRepositoryImpl implements ResourceRepository {
  final ResourceRemoteDataSource remoteDataSource;
  ResourceRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Resource>> getResourcesByCourse(String courseCode) async {
    return await remoteDataSource.getResourcesByCourse(courseCode);
  }

  @override
  Future<Resource> getResourceById(String id) async {
    return await remoteDataSource.getResourceById(id);
  }
}
