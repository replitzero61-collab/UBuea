import 'package:ub_t/core/common/entities/resource.dart';
import '../repository/resource_repository.dart';

class GetResourceById {
  final ResourceRepository repository;
  GetResourceById(this.repository);

  Future<Resource> call(String id) async {
    return await repository.getResourceById(id);
  }
}
