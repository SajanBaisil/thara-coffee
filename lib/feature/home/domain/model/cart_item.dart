class CartItem {
  final String id;
  final String? discount;
  final double price;
  final int quantity;
  final String? customerNote;
  final String? productName;

  CartItem(
      {required this.id,
      this.discount,
      required this.price,
      required this.quantity,
      this.customerNote,
      required this.productName});

  double get totalPrice => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'product_id': id,
      'discount': discount,
      'price_unit': price,
      'qty': quantity,
      'customer_note': customerNote,
      'name': productName
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['product_id'],
      discount: json['discount'],
      price: json['price_unit'],
      quantity: json['qty'],
      customerNote: json['customer_note'],
      productName: json['name'],
    );
  }
}
