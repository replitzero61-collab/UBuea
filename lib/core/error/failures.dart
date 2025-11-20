abstract class Failure {
  final String message;
  
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class PaymentFailure extends Failure {
  const PaymentFailure(super.message);
}

class NotificationFailure extends Failure {
  const NotificationFailure(super.message);
}

class StorageFailure extends Failure {
  const StorageFailure(super.message);
}
