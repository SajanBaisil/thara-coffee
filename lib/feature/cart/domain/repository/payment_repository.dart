import 'package:razorpay_flutter/razorpay_flutter.dart';

abstract class PaymentRepository {
  void initializePayment({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
    required Function(ExternalWalletResponse) onWallet,
  });

  void createPayment({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
    required Function(ExternalWalletResponse) onWallet,
    required String orderId,
    required double amount,
    required String customerName,
    required String email,
    required String contact,
    String? description,
  });

  void dispose();
}
