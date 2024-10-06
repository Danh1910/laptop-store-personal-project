class CartItem {
  String laptopId;int quantity;
  String name; // Optional
  double price; // Optional
  String? imageUrl; // Optional

  CartItem({
    required this.laptopId,
    required this.quantity,
    this.name = '',
    this.price = 0.0,
    this.imageUrl,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      laptopId: map['laptopId'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }
}