import '../repository/payment_repository.dart';

class IsPremiumUser {
  final PaymentRepository repository;
  IsPremiumUser(this.repository);

  Future<bool> call() async {
    return await repository.isPremiumUser();
  }
}
