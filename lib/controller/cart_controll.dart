import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:new_laptop_project/model/DTO/cart_dto.dart';
import 'package:new_laptop_project/model/service/cart_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/DTO/laptop_dto.dart';
import 'account_controller.dart';


class CartControll extends GetxController{

  final CartService _cartService = CartService();

  String? userId; // Khai báo userId




  Rx<Cart?> _cart = Rx<Cart?>(null);
  Cart? get cart => _cart.value;


  @override
  Future<void> onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    getCart();
  }



  void addItemToCart(Laptop laptop, int quantity) {
    if (userId != null) { // Kiểm tra userId trước khi sử dụng
      _cartService.addToCart(laptop, quantity, userId!);
      getCart();
    } else {
      // Xử lý trường hợp userId là null (ví dụ: hiển thị thông báo lỗi)
    }
  }


  Future<void> getCart() async{
    _cart.value = await _cartService.getCart(userId!);
    // print(_accountControll.userId);
  }

}
