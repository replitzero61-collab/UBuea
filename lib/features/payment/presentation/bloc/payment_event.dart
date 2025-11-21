import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
  @override
  List<Object?> get props => [];
}

class MakePaymentEvent extends PaymentEvent {
  final int amount;
  final String planId;
  const MakePaymentEvent({required this.amount, required this.planId});
  @override
  List<Object?> get props => [amount, planId];
}

class CheckPremiumStatusEvent extends PaymentEvent {}
