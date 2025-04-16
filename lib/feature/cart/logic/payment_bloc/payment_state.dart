import 'package:equatable/equatable.dart';
import 'package:thara_coffee/shared/components/datafetch_status.dart';

class PaymentState extends Equatable {
  final DataFetchStatus paymentStatus;
  final String? paymentId;
  final String? orderId;
  final String? errorMessage;
  final String? signature;
  final String? amount;

  const PaymentState({
    this.paymentStatus = DataFetchStatus.idle,
    this.paymentId,
    this.orderId,
    this.errorMessage,
    this.signature,
    this.amount,
  });

  PaymentState copyWith({
    DataFetchStatus? paymentStatus,
    String? paymentId,
    String? orderId,
    String? errorMessage,
    String? signature,
    String? amount,
  }) {
    return PaymentState(
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentId: paymentId ?? this.paymentId,
      orderId: orderId ?? this.orderId,
      errorMessage: errorMessage ?? this.errorMessage,
      signature: signature ?? this.signature,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [
        paymentStatus,
        paymentId,
        orderId,
        errorMessage,
        signature,
        amount,
      ];
}
