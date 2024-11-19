import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:new_laptop_project/controller/lap_controll.dart';
import 'package:new_laptop_project/model/DTO/laptop_dto.dart';

import '../../controller/cart_controll.dart';

class LaptopDetailsScreen extends StatelessWidget {
  LaptopDetailsScreen({
    super.key,
    required this.imagePath,
    required this.laptop,

  });

  final String imagePath;
  final Laptop laptop;

  final cartController = Get.put(CartControll());

  @override
  Widget build(BuildContext context) {

    final formatter = NumberFormat("#,##0");
    final formattedPrice = formatter.format(laptop.price);
    final formattedPrice2 = formatter.format(laptop.original_price);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sản phẩm'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/$imagePath"),
            Text(laptop.name),
            Text(
              formattedPrice2+"đ",
              style: TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            Text(
              formattedPrice+"đ",
              style: TextStyle(color: Colors.blue),
            ),
            ElevatedButton(
              onPressed: () {
                cartController.addItemToCart(laptop, 1);
                cartController.getCart();
              },
              child: const Text('Mua'),
            ),
          ],
        ),
      ),
    );
  }
}