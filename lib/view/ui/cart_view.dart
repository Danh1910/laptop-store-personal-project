import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:new_laptop_project/controller/cart_controll.dart';
import 'package:new_laptop_project/view/item/cart_item.dart';

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
              if (cartController.cart == null) {return CircularProgressIndicator();
              } else {
                return Expanded( // Sử dụng Expanded để ListView chiếm diện tích còn lại
                  child: Column( // Sử dụng Column để chứa ListView và Container
                    children: [
                      Expanded( // Cho ListView chiếm không gian còn lại trong Column
                        child: ListView.builder(
                          itemCount: cartController.cart!.items.length,
                          itemBuilder: (context, index) {
                            final item = cartController.cart!.items[index];
                            return CartItemUI(); // Hiển thị CartItem
                          },
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tổng tiền:"),
                                Text("\$100"), // Hiển thị tổng tiền
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text("Mua"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}