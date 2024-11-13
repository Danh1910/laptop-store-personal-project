import 'laptop_dto.dart';

class ChiTietHoaDon {
  final List<Laptop> laptops; // Danh sách sản phẩm
  final double tongGia; // Tổng giá

  ChiTietHoaDon({
    required this.laptops,
    required this.tongGia,
  });

  Map<String, dynamic> toMap() {
    return {
      'laptops': laptops.map((laptop) => laptop.toMap()).toList(), // Gọi toMap của Laptop
      'tongGia': tongGia,
    };
  }

  factory ChiTietHoaDon.fromMap(Map<String, dynamic> map) {
    return ChiTietHoaDon(
      laptops: (map['laptops'] as List<dynamic>?)
          ?.map((laptop) => Laptop.fromMap(laptop['id'] ?? '', laptop))
          .toList() ?? [],
      tongGia: map['tongGia']?.toDouble() ?? 0.0,
    );
  }
}