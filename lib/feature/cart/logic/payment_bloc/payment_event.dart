import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class InitiatePaymentEvent extends PaymentEvent {
  final String orderId;
  final double amount;
  final String customerName;
  final String email;
  final String contact;
  final String? description;

  const InitiatePaymentEvent({
    required this.orderId,
    required this.amount,
    required this.customerName,
    required this.email,
    required this.contact,
    this.description,
  });

  @override
  List<Object?> get props =>
      [orderId, amount, customerName, email, contact, description];
}

class InitializePaymentEvent extends PaymentEvent {
  const InitializePaymentEvent();

  @override
  List<Object?> get props => [];
}


