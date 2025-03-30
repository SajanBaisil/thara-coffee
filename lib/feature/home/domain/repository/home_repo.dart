import 'package:thara_coffee/feature/home/domain/model/category_model.dart';
import 'package:thara_coffee/feature/home/domain/model/product_model.dart';
import 'package:thara_coffee/feature/home/domain/model/single_product_model.dart';

abstract class HomeRepository {
  Future<CategoryModel> getCategoryList();
  Future<ProductData> getProductsByCategory({required String categoryId});
  Future<SingleProductData> fetchSingleProduct({
    required String productId,
  });
}
