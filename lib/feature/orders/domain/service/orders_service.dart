import 'package:thara_coffee/feature/home/domain/model/cart_item.dart';
import 'package:thara_coffee/feature/orders/domain/model/get_pos_order_model.dart';
import 'package:thara_coffee/feature/orders/domain/repository/orders_repository.dart';
import 'package:thara_coffee/shared/domain/constants/endpoints.dart';
import 'package:thara_coffee/shared/router/http%20utils/common_exception.dart';
import 'package:thara_coffee/shared/router/http%20utils/http_helper.dart';

class OrdersService extends OrdersRepository {
  @override
  Future<void> createPosOrder(
      {required String mobile,
      required String companyId,
      required String paymentId,
      required String paymentAmount,
      required List<CartItem> products}) async {
    final response = await HttpHelper.getDataFromServer(
      Endpoints.createPosOrder,
      requestType: RequestType.post,
      data: {
        'mobile': mobile,
        'company_id': int.tryParse(companyId) ?? 1,
        'payment_method_id': 3,
        // 'payment_method_id': paymentId,
        'amount_paid': int.tryParse(paymentAmount) ?? 0,
        'products': products.map((product) => product.toJson()).toList(),
      },
    );
    // final singleProductResponse =
    //     SingleProductData.fromJson(response.responseBody);
    if (!response.success) {
      throw ApiException(response.message, response.responseCode);
    }
    // return singleProductResponse;
  }

  @override
  Future<GetPosOrdersModel> getPosOrders({required String mobile}) async {
    final response = await HttpHelper.getDataFromServer(
      Endpoints.getPosOrder,
      requestType: RequestType.get,
      data: {'mobile': mobile},
    );

    final posOrderResponse = GetPosOrdersModel.fromJson(response.responseBody);

    if (!response.success) {
      throw ApiException(response.message, response.responseCode);
    }

    return posOrderResponse;
  }
}
