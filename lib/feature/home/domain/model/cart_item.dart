class CartItem {
  final String id;
  final String? discount;
  final double price;
  final int quantity;
  final String? customerNote;

  CartItem({
    required this.id,
    this.discount,
    required this.price,
    required this.quantity,
    this.customerNote,
  });

  double get totalPrice => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'product_id': id,
      'discount': discount,
      'price_unit': price,
      'qty': quantity,
      'customer_note': customerNote,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['product_id'],
      discount: json['discount'],
      price: json['price_unit'],
      quantity: json['qty'],
      customerNote: json['customer_note'],
    );
  }
}
