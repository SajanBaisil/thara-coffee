import 'package:equatable/equatable.dart';
import 'package:thara_coffee/feature/home/domain/model/category_model.dart';
import 'package:thara_coffee/feature/home/domain/model/product_model.dart';
import 'package:thara_coffee/feature/home/domain/model/single_product_model.dart';
import 'package:thara_coffee/shared/components/datafetch_status.dart';

class HomeState extends Equatable {
  final DataFetchStatus categoryFetchStatus;
  final DataFetchStatus productFetchStatus;
  final DataFetchStatus singleProductFetchStatus;
  final SingleProduct? singleProduct;
  final List<CategoryData>? categoryData;
  final List<ProductModel>? products;
  final List<ProductModel>? filteredProducts;
  final String selectedCategoryIndex;
  final String searchQuery;
  final String? errorMessage;

  const HomeState({
    this.categoryFetchStatus = DataFetchStatus.idle,
    this.productFetchStatus = DataFetchStatus.idle,
    this.singleProductFetchStatus = DataFetchStatus.idle,
    this.categoryData,
    this.products,
    this.filteredProducts,
    this.selectedCategoryIndex = '0',
    this.searchQuery = '',
    this.errorMessage,
    this.singleProduct,
  });

  @override
  List<Object?> get props => [
        categoryFetchStatus,
        productFetchStatus,
        categoryData,
        products,
        filteredProducts,
        selectedCategoryIndex,
        searchQuery,
        errorMessage,
        singleProduct,
        singleProductFetchStatus,
      ];

  HomeState copyWith({
    DataFetchStatus? categoryFetchStatus,
    DataFetchStatus? productFetchStatus,
    List<CategoryData>? categoryData,
    List<ProductModel>? products,
    List<ProductModel>? filteredProducts,
    String? selectedCategoryIndex,
    String? searchQuery,
    String? errorMessage,
    SingleProduct? singleProduct,
    DataFetchStatus? singleProductFetchStatus,
  }) {
    return HomeState(
      categoryFetchStatus: categoryFetchStatus ?? this.categoryFetchStatus,
      productFetchStatus: productFetchStatus ?? this.productFetchStatus,
      categoryData: categoryData ?? this.categoryData,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
      singleProduct: singleProduct ?? this.singleProduct,
      singleProductFetchStatus:
          singleProductFetchStatus ?? this.singleProductFetchStatus,
    );
  }
}
