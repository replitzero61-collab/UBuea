import 'package:ub_t/core/common/entities/user.dart';

abstract class AppUserState {
  const AppUserState();
}

class AppUserInitial extends AppUserState {
  const AppUserInitial();
}

class AppUserLoggedIn extends AppUserState {
  final User user;
  
  const AppUserLoggedIn(this.user);
}
