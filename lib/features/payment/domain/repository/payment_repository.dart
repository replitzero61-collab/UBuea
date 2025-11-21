abstract class PaymentRepository {
  Future<bool> makePayment({required int amount, required String planId});
  Future<bool> isPremiumUser();
}
