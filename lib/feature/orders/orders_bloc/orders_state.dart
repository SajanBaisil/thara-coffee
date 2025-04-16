part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  const OrdersState({
    this.createPosOrderStatus = DataFetchStatus.idle,
    this.getPosOrderFetchStatus = DataFetchStatus.idle,
    this.errorMessage,
    this.posOrders,
  });

  final DataFetchStatus createPosOrderStatus;
  final DataFetchStatus getPosOrderFetchStatus;
  final String? errorMessage;
  final GetPosOrdersModel? posOrders;

  @override
  List<Object?> get props => [
        createPosOrderStatus,
        getPosOrderFetchStatus,
        errorMessage,
        posOrders,
      ];

  OrdersState copyWith(
      {DataFetchStatus? createPosOrderStatus,
      DataFetchStatus? getPosOrderFetchStatus,
      String? errorMessage,
      GetPosOrdersModel? posOrders}) {
    return OrdersState(
      createPosOrderStatus: createPosOrderStatus ?? this.createPosOrderStatus,
      getPosOrderFetchStatus:
          getPosOrderFetchStatus ?? this.getPosOrderFetchStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      posOrders: posOrders ?? this.posOrders,
    );
  }
}
