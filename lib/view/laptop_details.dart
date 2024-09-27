import 'package:flutter/material.dart';

class LaptopDetailsScreen extends StatelessWidget {
  const LaptopDetailsScreen({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.brand
  });

  final String imagePath;
  final String name;
  final int price;
  final String brand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sản phẩm'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath),
            Text(name),
            Text(price.toString()),
            // Hiển thị thêm thông tin chi tiết khác ở đây
          ],
        ),
      ),
    );
  }
}