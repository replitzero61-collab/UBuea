import 'package:ub_t/core/common/entities/resource.dart';

abstract class ResourceRepository {
  Future<List<Resource>> getResourcesByCourse(String courseCode);
  Future<Resource> getResourceById(String id);
}
