part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class CreatePosOrder extends OrdersEvent {
  const CreatePosOrder({
    required this.mobile,
    required this.companyId,
    required this.paymentId,
    required this.paymentAmount,
    required this.products,
  });

  final String mobile;
  final String companyId;
  final String paymentId;
  final String paymentAmount;
  final List<CartItem> products;
  @override
  List<Object> get props => [
        mobile,
        companyId,
        paymentId,
        paymentAmount,
        products,
      ];
}

class GetPosOrderEvent extends OrdersEvent {
  const GetPosOrderEvent({required this.mobile});

  final String mobile;

  @override
  List<Object> get props => [mobile];
}
