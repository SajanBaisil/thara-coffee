import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class CategoryFetchEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class CategorySelectedEvent extends HomeEvent {
  final String categoryId;
  const CategorySelectedEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class SearchProductsEvent extends HomeEvent {
  final String query;
  const SearchProductsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class RefreshEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class SingleProductFetchEvent extends HomeEvent {
  final String productId;
  const SingleProductFetchEvent(this.productId);
  @override
  List<Object?> get props => [productId];
}
