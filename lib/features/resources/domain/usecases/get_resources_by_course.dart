import 'package:ub_t/core/common/entities/resource.dart';
import '../repository/resource_repository.dart';

class GetResourcesByCourse {
  final ResourceRepository repository;
  GetResourcesByCourse(this.repository);

  Future<List<Resource>> call(String courseCode) async {
    return await repository.getResourcesByCourse(courseCode);
  }
}
