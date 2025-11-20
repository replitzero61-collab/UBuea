import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ub_t/core/common/cubits/app_user/app_user_state.dart';
import 'package:ub_t/core/common/entities/user.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(const AppUserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(const AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }
}
