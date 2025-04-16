import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:thara_coffee/feature/cart/domain/repository/payment_repository.dart';
import 'package:thara_coffee/feature/cart/logic/payment_bloc/payment_event.dart';
import 'package:thara_coffee/feature/cart/logic/payment_bloc/payment_state.dart';
import 'package:thara_coffee/shared/components/datafetch_status.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<InitializePaymentEvent>(_onInitializePayment);
    on<InitiatePaymentEvent>(onInitiatePayment);
  }

  final _paymentRepository = serviceLocator<PaymentRepository>();

  Future<void> _onInitializePayment(
    InitializePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final completer = Completer<void>();

    _paymentRepository.initializePayment(
      onSuccess: (response) {
        if (!emit.isDone) {
          handlePaymentSuccess(response, event, emit);
        }
      },
      onFailure: (response) {
        if (!emit.isDone) {
          handlePaymentFailure(response, event, emit);
        }
      },
      onWallet: (response) {
        if (!emit.isDone) {
          handleExternalWallet(response, event, emit);
        }
      },
    );

    emit(state.copyWith(paymentStatus: DataFetchStatus.success));
    await completer.future;
  }

  Future<void> onInitiatePayment(
    InitiatePaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final completer = Completer<void>();

    try {
      emit(state.copyWith(
        paymentStatus: DataFetchStatus.waiting,
        orderId: event.orderId,
      ));
      _paymentRepository.createPayment(
        onSuccess: (response) {
          handlePaymentSuccess(response, event, emit);
        },
        onFailure: (response) {
          handlePaymentFailure(response, event, emit);
        },
        onWallet: (response) {
          handleExternalWallet(response, event, emit);
        },
        orderId: event.orderId,
        amount: event.amount,
        customerName: event.customerName,
        email: event.email,
        contact: event.contact,
        description: event.description,
      );
      await completer.future;
    } catch (e) {
      if (!emit.isDone) {
        emit(state.copyWith(
          paymentStatus: DataFetchStatus.failed,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  void handlePaymentSuccess(
    PaymentSuccessResponse response,
    event,
    Emitter<PaymentState> emit,
  ) {
    if (!emit.isDone) {
      emit(state.copyWith(
        paymentStatus: DataFetchStatus.success,
        paymentId: response.paymentId,
        orderId: response.orderId,
        amount: event is InitiatePaymentEvent
            ? event.amount.toString()
            : state.amount,
        signature: response.signature,
      ));
    }
  }

  void handlePaymentFailure(
    PaymentFailureResponse response,
    event,
    Emitter<PaymentState> emit,
  ) {
    if (!emit.isDone) {
      emit(state.copyWith(
        paymentStatus: DataFetchStatus.failed,
        errorMessage: response.message ?? 'Payment failed',
      ));
    }
  }

  void handleExternalWallet(
    ExternalWalletResponse response,
    event,
    Emitter<PaymentState> emit,
  ) {
    // Handle external wallet if needed
  }

  @override
  Future<void> close() {
    _paymentRepository.dispose();
    return super.close();
  }
}
