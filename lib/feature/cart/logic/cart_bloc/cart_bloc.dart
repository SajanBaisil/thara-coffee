import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thara_coffee/feature/home/domain/model/cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddToCartEvent>(_addToCart);
    on<UpdateCartItemQuantityEvent>(_updateQuantity);
  }

  Future<void> _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    try {
      final currentItems = List<CartItem>.from(state.items);
      final existingItemIndex =
          currentItems.indexWhere((item) => item.id == event.item.id);

      if (existingItemIndex != -1) {
        // Update existing item quantity
        final existingItem = currentItems[existingItemIndex];
        currentItems[existingItemIndex] = CartItem(
          id: existingItem.id,
          // name: existingItem.name,
          price: existingItem.price,
          quantity: existingItem.quantity + event.item.quantity,
          customerNote: event.item.customerNote ?? existingItem.customerNote,
        );
      } else {
        // Add new item
        currentItems.add(event.item);
      }

      _updateState(emit, currentItems);
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to add item to cart: ${e.toString()}',
      ));
    }
  }

  Future<void> _updateQuantity(
    UpdateCartItemQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      final currentItems = List<CartItem>.from(state.items);
      final itemIndex =
          currentItems.indexWhere((item) => item.id == event.itemId);

      if (itemIndex != -1) {
        if (event.quantity <= 0) {
          // Remove item if quantity is 0 or less
          currentItems.removeAt(itemIndex);
        } else {
          // Update quantity
          final item = currentItems[itemIndex];
          currentItems[itemIndex] = CartItem(
            id: item.id,
            // name: item.name,
            price: item.price,
            quantity: event.quantity,
            customerNote: item.customerNote,
          );
        }

        _updateState(emit, currentItems);
      }
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to update quantity: ${e.toString()}',
      ));
    }
  }

  void _updateState(Emitter<CartState> emit, List<CartItem> items) {
    final totalAmount = items.fold<double>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    emit(state.copyWith(
      items: items,
      totalAmount: totalAmount,
    ));
  }
}
