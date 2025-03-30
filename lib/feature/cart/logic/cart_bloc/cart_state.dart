part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final double totalAmount;
  final String? errorMessage;

  const CartState({
    this.items = const [],
    this.totalAmount = 0.0,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [items, totalAmount, errorMessage];

  CartState copyWith({
    List<CartItem>? items,
    double? totalAmount,
    String? errorMessage,
  }) {
    return CartState(
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
