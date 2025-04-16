import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:thara_coffee/shared/router/http%20utils/common_exception.dart';

import '../repository/payment_repository.dart';

class PaymentService extends PaymentRepository {
  final Razorpay _razorpay = Razorpay();
  // static const _razorpayKey = 'xOdUpkgD4SaPy5tDp0WB7uOB';
  static const _razorpayKey = 'rzp_test_vJ6FiB08xakeFW';

  @override
  void initializePayment({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
    required Function(ExternalWalletResponse) onWallet,
  }) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onWallet);
  }

  @override
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
  }) async {
    try {
      // final data = {
      //   'order_id': orderId,
      //   'amount': amount,
      //   'currency': 'INR',
      // };

      // // Create order on your backend
      // final response = await HttpHelper.getDataFromServer(
      //   Endpoints.createOrder,
      //   data: data,
      // );

      // if (!response.success) {
      //   throw ApiException(response.message, response.responseCode);
      // }

      final options = {
        'key': _razorpayKey,
        'amount': (amount * 100).toInt(),
        'name': 'Thara Coffee',
        'description': description ?? 'Coffee Order Payment',
        // 'order_id': orderId,
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'prefill': {
          'name': customerName,
          'contact': contact,
          'email': email,
        },
        'theme': {
          'color': '#FC545B',
        },
        'currency': 'INR',
      };
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onFailure);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onWallet);
      _razorpay.open(options);
    } catch (e) {
      throw ApiException(
        'Failed to initialize payment: ${e.toString()}',
        500,
      );
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
  }
}
