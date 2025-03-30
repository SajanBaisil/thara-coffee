import 'package:bloc/bloc.dart';
import 'package:thara_coffee/feature/home/domain/repository/home_repo.dart';
import 'package:thara_coffee/feature/home/logic/home_bloc/home_event.dart';
import 'package:thara_coffee/feature/home/logic/home_bloc/home_state.dart';
import 'package:thara_coffee/shared/components/datafetch_status.dart';
import 'package:thara_coffee/shared/domain/constants/global_variables.dart';
import 'package:thara_coffee/shared/router/http%20utils/common_exception.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<CategoryFetchEvent>(_onCategoryFetchEvent);
    on<CategorySelectedEvent>(_onCategorySelected);
    on<SearchProductsEvent>(_onSearchProducts);
    on<RefreshEvent>(_onRefresh);
    on<SingleProductFetchEvent>(_singleProductFetch);
  }

  final _homeRepo = serviceLocator<HomeRepository>();

  Future<void> _singleProductFetch(
    SingleProductFetchEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(singleProductFetchStatus: DataFetchStatus.waiting));
    try {
      final product =
          await _homeRepo.fetchSingleProduct(productId: event.productId);
      emit(
        state.copyWith(
            singleProductFetchStatus: DataFetchStatus.success,
            singleProduct: product.data?.first),
      );
    } catch (e) {
      emit(
        state.copyWith(
            singleProductFetchStatus: DataFetchStatus.failed,
            errorMessage:
                e is ApiException ? e.message : 'Something went wrong'),
      );
    }
  }

  Future<void> _onRefresh(
    RefreshEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      categoryFetchStatus: DataFetchStatus.waiting,
      productFetchStatus: DataFetchStatus.waiting,
    ));

    try {
      // Refresh categories
      final categoryList = await _homeRepo.getCategoryList();
      emit(state.copyWith(
        categoryFetchStatus: DataFetchStatus.success,
        categoryData: categoryList.data,
      ));

      // Refresh products for current category
      if (categoryList.data?.isNotEmpty ?? false) {
        final currentCategoryId = state.selectedCategoryIndex;

        final products = await _homeRepo.getProductsByCategory(
          categoryId: currentCategoryId,
        );

        emit(state.copyWith(
          productFetchStatus: DataFetchStatus.success,
          products: products.data,
          filteredProducts: products.data,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        categoryFetchStatus: DataFetchStatus.failed,
        productFetchStatus: DataFetchStatus.failed,
        errorMessage: e is ApiException ? e.message : 'Something went wrong',
      ));
    }
  }

  Future<void> _onCategorySelected(
    CategorySelectedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      selectedCategoryIndex: event.categoryId,
      productFetchStatus: DataFetchStatus.waiting,
    ));
    try {
      final products = await _homeRepo.getProductsByCategory(
        categoryId: event.categoryId,
      );
      emit(state.copyWith(
        productFetchStatus: DataFetchStatus.success,
        products: products.data,
        filteredProducts: products.data,
      ));
    } catch (e) {
      emit(state.copyWith(
        productFetchStatus: DataFetchStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onSearchProducts(
    SearchProductsEvent event,
    Emitter<HomeState> emit,
  ) {
    final query = event.query.toLowerCase();
    if (query.isEmpty) {
      emit(state.copyWith(
        searchQuery: query,
        filteredProducts: state.products,
      ));
    } else {
      final filteredProducts = state.products
          ?.where((product) =>
              (product.name?.toLowerCase().contains(query) ?? false))
          .toList();
      emit(state.copyWith(
        searchQuery: query,
        filteredProducts: filteredProducts,
      ));
    }
  }

  Future<void> _onCategoryFetchEvent(
    CategoryFetchEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(categoryFetchStatus: DataFetchStatus.waiting));
    try {
      final categoryList = await _homeRepo.getCategoryList();
      emit(state.copyWith(
        categoryFetchStatus: DataFetchStatus.success,
        categoryData: categoryList.data,
      ));
      // Fetch products for first category
      // if (categoryList.data?.isNotEmpty ?? false) {
      //   add(CategorySelectedEvent('0'));
      // }
    } catch (e) {
      emit(state.copyWith(
        categoryFetchStatus: DataFetchStatus.failed,
        errorMessage: e is ApiException ? e.message : 'Something went wrong',
      ));
    }
  }
}
