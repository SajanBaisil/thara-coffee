import 'package:equatable/equatable.dart';
import 'package:thara_coffee/shared/extensions/on_json.dart';

class PaymentResponse with EquatableMixin {
  final String success;
  final String? paymentId;
  final String? orderId;
  final String? signature;
  final String? errorMessage;

  PaymentResponse({
    required this.success,
    this.paymentId,
    this.orderId,
    this.signature,
    this.errorMessage,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> newJson) {
    final json = newJson.jsonStringify();
    return PaymentResponse(
      success: json['success'] ?? false,
      paymentId: json['payment_id'],
      orderId: json['order_id'],
      signature: json['signature'],
      errorMessage: json['error_message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'payment_id': paymentId,
      'order_id': orderId,
      'signature': signature,
      'error_message': errorMessage,
    };
  }

  @override
  List<Object?> get props => [
        success,
        paymentId,
        orderId,
        signature,
        errorMessage,
      ];
}
