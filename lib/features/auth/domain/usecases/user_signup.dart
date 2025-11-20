import 'package:fpdart/fpdart.dart';
import 'package:ub_t/core/common/entities/user.dart';
import 'package:ub_t/core/error/failures.dart';
import 'package:ub_t/core/usecase_interface/usecase.dart';
import 'package:ub_t/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithMatricule(
      matriculeNumber: params.matriculeNumber,
      password: params.password,
      department: params.department,
      level: params.level,
    );
  }
}

class UserSignUpParams {
  final String matriculeNumber;
  final String password;
  final String department;
  final int level;

  UserSignUpParams({
    required this.matriculeNumber,
    required this.password,
    required this.department,
    required this.level,
  });
}
