import 'package:fpdart/fpdart.dart';
import 'package:ub_t/core/common/entities/user.dart';
import 'package:ub_t/core/error/failures.dart';
import 'package:ub_t/core/usecase_interface/usecase.dart';
import 'package:ub_t/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }
}
