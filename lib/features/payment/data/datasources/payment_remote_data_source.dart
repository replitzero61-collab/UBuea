abstract class PaymentRemoteDataSource {
  Future<bool> makePayment({required int amount, required String planId});
  Future<bool> isPremiumUser();
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  @override
  Future<bool> makePayment({
    required int amount,
    required String planId,
  }) async {
    // TODO: Integrate with Flutterwave or payment API
    return false;
  }

  @override
  Future<bool> isPremiumUser() async {
    // TODO: Check premium status from backend
    return false;
  }
}
