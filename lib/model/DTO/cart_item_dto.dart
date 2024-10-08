import 'package:new_laptop_project/model/DTO/laptop_dto.dart';

class CartItem {
  int quantity;
  Laptop laptop; // Laptop object

  CartItem({
    required this.quantity,
    required this.laptop, //Thêm Laptop vào constructor
  });

  // Factory constructor to create a CartItem from a Map (optional)
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      quantity: map['quantity']?.toInt() ?? 0,
      laptop: Laptop.fromMap(map['laptopId'] ?? '', map['laptop'] ?? {}), // Tạo Laptop object từ map
    );
  }
}