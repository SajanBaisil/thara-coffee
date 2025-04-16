import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thara_coffee/feature/home/domain/model/cart_item.dart';
import 'package:thara_coffee/feature/orders/domain/model/get_pos_order_model.dart';
import 'package:thara_coffee/feature/orders/domain/repository/orders_repository.dart';
import 'package:thara_coffee/shared/components/datafetch_status.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/router/http%20utils/common_exception.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersState()) {
    on<CreatePosOrder>(_createPostOrder);
    on<GetPosOrderEvent>(_getPosOrder);
  }

  final _orderRepo = serviceLocator<OrdersRepository>();

  Future<void> _getPosOrder(
    GetPosOrderEvent event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      emit(state.copyWith(
        getPosOrderFetchStatus: DataFetchStatus.waiting,
      ));

      final response = await _orderRepo.getPosOrders(mobile: event.mobile);
      emit(state.copyWith(
          posOrders: response,
          getPosOrderFetchStatus: DataFetchStatus.success));
    } catch (e) {
      state.copyWith(
          getPosOrderFetchStatus: DataFetchStatus.failed,
          errorMessage: e is ApiException
              ? e.message
              : 'Unable to fetch pos order, please try again later');
    }
  }

  Future<void> _createPostOrder(
    CreatePosOrder event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      emit(state.copyWith(
        createPosOrderStatus: DataFetchStatus.waiting,
      ));
      _orderRepo.createPosOrder(
          mobile: event.mobile,
          companyId: event.companyId,
          paymentId: event.paymentId,
          paymentAmount: event.paymentAmount,
          products: event.products);

      emit(state.copyWith(
        createPosOrderStatus: DataFetchStatus.success,
      ));
    } catch (e) {
      state.copyWith(
          createPosOrderStatus: DataFetchStatus.failed,
          errorMessage: e is ApiException
              ? e.message
              : 'Unable to create pos order, please try again later');
    }
  }
}
