class Laptop {
  final String? id;
  final String name;
  final String brand;
  final int price;
  final String image;

  Laptop({this.id, required this.name, required this.brand, required this.price, required this.image});

  // Chuyển đổi object Laptop thành Map để lưu trữ trên Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'price': price,
      'image' : image
    };
  }

  // Tạo object Laptop từ Map lấy từ Firestore
  factory Laptop.fromMap(String id, Map<String, dynamic> map) {
    return Laptop(
      id: id,
      name: map['name'] ?? '',
      brand: map['brand'] ?? '',
      price: map['price']?.toInt() ?? 0.0,
      image: map['image'] ?? ''
    );
  }
}