import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:new_laptop_project/model/DTO/cart_dto.dart';
import 'package:new_laptop_project/model/service/cart_service.dart';

import '../model/DTO/laptop_dto.dart';


class CartControll extends GetxController{

  final CartService _cartService = CartService();

  Rx<Cart?> _cart = Rx<Cart?>(null);
  Cart? get cart => _cart.value;


  @override
  void onInit() {
    super.onInit();
    getCart();
  }



  void addItemToCart(Laptop laptop, int quantity) { // Thay đổi hàm themcart
    _cartService.addToCart(laptop, quantity); // Gọi addToCart với Laptop object
    getCart(); // Cập nhật giỏ hàng sau khi thêm
  }


  Future<void> getCart() async{
    _cart.value = await _cartService.getCart();
  }

}
