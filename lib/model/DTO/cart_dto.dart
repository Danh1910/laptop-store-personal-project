import 'cart_item_dto.dart';

class Cart {
  List<CartItem> items;
  double totalPrice;
  String? userId;

  Cart({
    required this.items,
    required this.totalPrice,
    this.userId,
  });

  factory Cart.fromMap(Map<String, dynamic> map) {
    final List<CartItem> items = (map['items'] as List)
        .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
        .toList();
    final double totalPrice = map['totalPrice'] ?? 0.0;

    return Cart(items: items, totalPrice: totalPrice);
  }
}