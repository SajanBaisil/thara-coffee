import 'package:thara_coffee/feature/home/domain/model/cart_item.dart';
import 'package:thara_coffee/feature/orders/domain/model/get_pos_order_model.dart';

abstract class OrdersRepository {
  Future<void> createPosOrder({
    required String mobile,
    required String companyId,
    required String paymentId,
    required String paymentAmount,
    required List<CartItem> products,
  });

  Future<GetPosOrdersModel> getPosOrders({required String mobile});
}
