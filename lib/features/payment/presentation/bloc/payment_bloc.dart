import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_event.dart';
import 'payment_state.dart';
import '../../domain/usecases/make_payment.dart';
import '../../domain/usecases/is_premium_user.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final MakePayment makePayment;
  final IsPremiumUser isPremiumUser;
  PaymentBloc({required this.makePayment, required this.isPremiumUser})
    : super(PaymentInitial()) {
    on<MakePaymentEvent>((event, emit) async {
      emit(PaymentLoading());
      try {
        final result = await makePayment(
          amount: event.amount,
          planId: event.planId,
        );
        if (result) {
          emit(PaymentSuccess());
        } else {
          emit(const PaymentFailure('Payment failed'));
        }
      } catch (e) {
        emit(PaymentFailure(e.toString()));
      }
    });
    on<CheckPremiumStatusEvent>((event, emit) async {
      emit(PaymentLoading());
      try {
        final isPremium = await isPremiumUser();
        if (isPremium) {
          emit(PremiumUser());
        } else {
          emit(NotPremiumUser());
        }
      } catch (e) {
        emit(PaymentFailure(e.toString()));
      }
    });
  }
}
