part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final CartItem item;

  const AddToCartEvent(this.item);

  @override
  List<Object> get props => [item];
}

class UpdateCartItemQuantityEvent extends CartEvent {
  final String itemId;
  final int quantity;

  const UpdateCartItemQuantityEvent({
    required this.itemId,
    required this.quantity,
  });

  @override
  List<Object> get props => [itemId, quantity];
}

// remove all cart items
class RemoveAllCartItems extends CartEvent {
  const RemoveAllCartItems();
  @override
  List<Object> get props => [];
}
