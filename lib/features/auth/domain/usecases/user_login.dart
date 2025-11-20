import 'package:fpdart/fpdart.dart';
import 'package:ub_t/core/common/entities/user.dart';
import 'package:ub_t/core/error/failures.dart';
import 'package:ub_t/core/usecase_interface/usecase.dart';
import 'package:ub_t/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithMatricule(
      matriculeNumber: params.matriculeNumber,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String matriculeNumber;
  final String password;

  UserLoginParams({
    required this.matriculeNumber,
    required this.password,
  });
}
