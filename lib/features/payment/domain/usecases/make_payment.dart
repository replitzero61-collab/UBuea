import '../repository/payment_repository.dart';

class MakePayment {
  final PaymentRepository repository;
  MakePayment(this.repository);

  Future<bool> call({required int amount, required String planId}) async {
    return await repository.makePayment(amount: amount, planId: planId);
  }
}
