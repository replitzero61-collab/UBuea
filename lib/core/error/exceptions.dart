class ServerException implements Exception {
  final String message;
  
  const ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  
  const CacheException(this.message);
}

class NetworkException implements Exception {
  final String message;
  
  const NetworkException(this.message);
}

class AuthException implements Exception {
  final String message;
  
  const AuthException(this.message);
}

class ValidationException implements Exception {
  final String message;
  
  const ValidationException(this.message);
}

class PaymentException implements Exception {
  final String message;
  
  const PaymentException(this.message);
}

class NotificationException implements Exception {
  final String message;
  
  const NotificationException(this.message);
}

class StorageException implements Exception {
  final String message;
  
  const StorageException(this.message);
}
