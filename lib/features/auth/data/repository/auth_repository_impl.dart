import 'package:fpdart/fpdart.dart';
import 'package:ub_t/core/common/entities/user.dart';
import 'package:ub_t/core/error/exceptions.dart';
import 'package:ub_t/core/error/failures.dart';
import 'package:ub_t/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ub_t/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> signUpWithMatricule({
    required String matriculeNumber,
    required String password,
    required String department,
    required int level,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithMatricule(
        matriculeNumber: matriculeNumber,
        password: password,
        department: department,
        level: level,
      );
      
      return right(user.toEntity());
    } on AuthException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithMatricule({
    required String matriculeNumber,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.loginWithMatricule(
        matriculeNumber: matriculeNumber,
        password: password,
      );
      
      return right(user.toEntity());
    } on AuthException catch (e) {
      return left(AuthFailure(e.message));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      
      if (user == null) {
        return left(const AuthFailure('User not logged in'));
      }
      
      return right(user.toEntity());
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }
}
