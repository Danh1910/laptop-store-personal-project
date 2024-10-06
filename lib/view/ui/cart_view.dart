import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:new_laptop_project/controller/cart_controll.dart';

class CartView extends StatelessWidget {

  final cartController = Get.put(CartControll());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextButton(onPressed: cartController.themcart, child: Text("Thêm Cart")),
            TextButton(
                onPressed: () => cartController.getCart(), child: Text("Đọc Cart")),
            Obx(() {
              if (cartController.cart == null) {
                return CircularProgressIndicator();
              } else {
                return Text(
                    "Giỏ hàng:\n${cartController.cart!.items.map((item) => "${item.laptopId}: ${item.quantity}").join("\n")}");
              }
            }),
          ],
        ),
      ),
    );
  }
}