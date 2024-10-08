import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sản phẩm'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/$imagePath"),
            Text("id sản phẩm: ${laptop.id}"),
            Text(laptop.name),
            Text(laptop.price.toString()),
            ElevatedButton(
              onPressed: () {

              },
              child: const Text('Mua'),
            ),
          ],
        ),
      ),
    );
  }
}