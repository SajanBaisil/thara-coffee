import 'package:thara_coffee/feature/home/domain/model/category_model.dart';
import 'package:thara_coffee/feature/home/domain/model/product_model.dart';
import 'package:thara_coffee/feature/home/domain/model/single_product_model.dart';
import 'package:thara_coffee/feature/home/domain/repository/home_repo.dart';
import 'package:thara_coffee/shared/domain/constants/endpoints.dart';
import 'package:thara_coffee/shared/router/http%20utils/common_exception.dart';
import 'package:thara_coffee/shared/router/http%20utils/http_helper.dart';

class HomeService extends HomeRepository {
  @override
  Future<CategoryModel> getCategoryList() async {
    final response = await HttpHelper.getDataFromServer(
      Endpoints.category,
    );
    final categoryResponse = CategoryModel.fromJson(response.responseBody);
    if (!response.success) {
      throw ApiException(response.message, response.responseCode);
    }
    return categoryResponse;
  }

  @override
  Future<ProductData> getProductsByCategory(
      {required String categoryId}) async {
    final response = await HttpHelper.getDataFromServer(
      Endpoints.product,
      data: {
        'category_id': categoryId,
      },
    );
    final productResponse = ProductData.fromJson(response.responseBody);
    if (!response.success) {
      throw ApiException(response.message, response.responseCode);
    }
    return productResponse;
  }

  @override
  Future<SingleProductData> fetchSingleProduct(
      {required String productId}) async {
    final response = await HttpHelper.getDataFromServer(
      Endpoints.singleProduct,
      requestType: RequestType.get,
      data: {
        'product_id': productId,
      },
    );
    final singleProductResponse =
        SingleProductData.fromJson(response.responseBody);
    if (!response.success) {
      throw ApiException(response.message, response.responseCode);
    }
    return singleProductResponse;
  }
}
