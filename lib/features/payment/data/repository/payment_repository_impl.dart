import '../../domain/repository/payment_repository.dart';
import '../datasources/payment_remote_data_source.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;
  PaymentRepositoryImpl(this.remoteDataSource);

  @override
  Future<bool> makePayment({
    required int amount,
    required String planId,
  }) async {
    return await remoteDataSource.makePayment(amount: amount, planId: planId);
  }

  @override
  Future<bool> isPremiumUser() async {
    return await remoteDataSource.isPremiumUser();
  }
}
