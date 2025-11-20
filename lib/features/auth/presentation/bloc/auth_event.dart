abstract class AuthEvent {
  const AuthEvent();
}

class AuthSignUp extends AuthEvent {
  final String matriculeNumber;
  final String password;
  final String department;
  final int level;

  const AuthSignUp({
    required this.matriculeNumber,
    required this.password,
    required this.department,
    required this.level,
  });
}

class AuthLogin extends AuthEvent {
  final String matriculeNumber;
  final String password;

  const AuthLogin({
    required this.matriculeNumber,
    required this.password,
  });
}

class AuthIsUserLoggedIn extends AuthEvent {
  const AuthIsUserLoggedIn();
}
