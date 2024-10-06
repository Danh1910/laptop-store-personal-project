import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_laptop_project/model/DTO/cart_dto.dart';

import '../DTO/cart_item_dto.dart';

class CartService {
  final CollectionReference _carts = FirebaseFirestore.instance.collection('carts');

  Future<void> addToCart(String laptopId, int quantity) async {
    try {
      final cartDoc = _carts.doc('cart'); // Document ID cố định là "cart"
      final cartSnapshot = await cartDoc.get();

      if (cartSnapshot.exists) {
        // Giỏ hàng đã tồn tại
        final cartData = cartSnapshot.data() as Map<String, dynamic>;
        final cartItems = cartData['items'] as List;
        final existingItemIndex = cartItems.indexWhere(
                (item) =>
            (item as Map<String, dynamic>)['laptopId'] == laptopId);

        if (existingItemIndex != -1) {
          // Sản phẩm đã tồn tại, tăng số lượng
          cartItems[existingItemIndex]['quantity'] += quantity;
        } else {
          // Sản phẩm chưa tồn tại, thêm mới
          cartItems.add({'laptopId': laptopId, 'quantity': quantity});
        }

        // Cập nhật giỏ hàng trên Firestore
        await cartDoc.update({'items': cartItems});
      } else {
        // Giỏ hàng chưa tồn tại, tạo mới
        await cartDoc.set({
          'items': [
            {'laptopId': laptopId, 'quantity': quantity}
          ],
          'totalPrice': 0, // Cập nhật tổng giá sau
        });
      }
    }
      catch (e) {
      print('Lỗi khi thêm sản phẩm vào giỏ hàng: $e');
    }
  }

  Future<Cart?> getCart() async {
    try {
      final cartDoc = _carts.doc('cart'); // Document IDcố định là "cart"
      final cartSnapshot = await cartDoc.get();

      if (cartSnapshot.exists) {
        // Giỏ hàng tồn tại
        final cartData = cartSnapshot.data() as Map<String, dynamic>;
        final List<CartItem> items= (cartData['items'] as List)
            .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
            .toList();
        final double totalPrice = (cartData['totalPrice'] as int).toDouble();

        return Cart(items: items, totalPrice: totalPrice);
      } else {
        // Giỏ hàng chưa tồn tại
        return null;
      }
    } catch (e) {
      print('Lỗi khi lấy giỏ hàng: $e');
      return null;
    }
  }

}