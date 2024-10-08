class Laptop {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String image;
  String? imageUrl;

  Laptop(
      {
        required this.id,
        required this.name,
        required this.brand,
        required this.price,
        required this.image,
        this.imageUrl,
      }
      );

  // Chuyển đổi object Laptop thành Map để lưu trữ trên Firestore
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name': name,
      'brand': brand,
      'price': price,
      'image' : image,
    };
  }

  // Tạo object Laptop từ Map lấy từ Firestore
  factory Laptop.fromMap(String id, Map<String, dynamic> map) {
    return Laptop(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      brand: map['brand'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
      imageUrl: map['imageUrl'] ?? ''
    );
  }


}