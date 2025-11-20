import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ub_t/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:ub_t/core/common/entities/user.dart';
import 'package:ub_t/core/usecase_interface/usecase.dart';
import 'package:ub_t/features/auth/domain/usecases/current_user.dart';
import 'package:ub_t/features/auth/domain/usecases/user_login.dart';
import 'package:ub_t/features/auth/domain/usecases/user_signup.dart';
import 'package:ub_t/features/auth/presentation/bloc/auth_event.dart';
import 'package:ub_t/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(const AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await _userSignUp(
      UserSignUpParams(
        matriculeNumber: event.matriculeNumber,
        password: event.password,
        department: event.department,
        level: event.level,
      ),
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await _userLogin(
      UserLoginParams(
        matriculeNumber: event.matriculeNumber,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final result = await _currentUser(NoParams());

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
