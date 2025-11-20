import 'package:fpdart/fpdart.dart';
import 'package:ub_t/core/common/entities/user.dart';
import 'package:ub_t/core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithMatricule({
    required String matriculeNumber,
    required String password,
    required String department,
    required int level,
  });

  Future<Either<Failure, User>> loginWithMatricule({
    required String matriculeNumber,
    required String password,
  });

  Future<Either<Failure, User>> getCurrentUser();
}
