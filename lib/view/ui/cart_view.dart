import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:new_laptop_project/controller/cart_controll.dart';
import 'package:new_laptop_project/controller/hoadon_controller.dart';
import 'package:new_laptop_project/view/item/cart_item.dart';

import '../../model/DTO/cart_item_dto.dart';
import '../../model/DTO/chitiethoadon_dto.dart';
import '../../model/DTO/hoadon_dto.dart';
import '../../model/DTO/laptop_dto.dart';
import '../../model/service/hoadon_service.dart';

class CartView extends StatelessWidget {
  final cartController = Get.put(CartControll());
  final hoaDonControll = Get.put(hoadonControll());

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
            Obx(() {
              if (cartController.cart == null) {return CircularProgressIndicator();
              } else {
                final formatter = NumberFormat("#,##0");
                final formattedPrice = formatter.format(cartController.cart!.totalPrice);

                return Expanded( // Sử dụng Expanded để ListView chiếm diện tích còn lại
                  child: Column( // Sử dụng Column để chứa ListView và Container
                    children: [
                      Expanded( // Cho ListView chiếm không gian còn lại trong Column
                        child: ListView.builder(
                          itemCount: cartController.cart!.items.length,
                          itemBuilder: (context, index) {
                            final item = cartController.cart!.items[index];
                            return CartItemUI(
                                item: item,
                              onIncrement: () {
                                // Gọi hàm updateCartItemQuantity trong CartController để tăng số lượng
                                cartController.updateCartItemQuantity(item, item.quantity + 1);
                                cartController.getCart();
                              },
                              onDecrement: () {
                                // Gọi hàm updateCartItemQuantity trong CartController để giảm số lượng
                                if (item.quantity > 1) {
                                  cartController.updateCartItemQuantity(item, item.quantity - 1);
                                  cartController.getCart();
                                }
                              },
                            ); // Hiển thị CartItem
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
                                Text(formattedPrice+"đ"), // Hiển thị tổng tiền
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (cartController.cart != null && cartController.cart!.items.isNotEmpty) {
                                  final cartItems = cartController.cart!.items;
                                  hoaDonControll.taoHoaDonVaChiTiet(cartItems);
                                } else {
                                  // Xử lý trường hợp giỏ hàng rỗng (ví dụ: hiển thị thông báo)
                                  print('Giỏ hàng rỗng!');
                                }},
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