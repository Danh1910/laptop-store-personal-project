import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_laptop_project/model/DTO/cart_dto.dart';

import '../DTO/cart_item_dto.dart';
import '../DTO/laptop_dto.dart';

class CartService {
  final CollectionReference _carts = FirebaseFirestore.instance.collection('carts');

  Future<void> addToCart(Laptop laptop, int quantity) async {
    try {
      final cartDoc = _carts.doc('cart');
      final cartSnapshot = await cartDoc.get();

      if (cartSnapshot.exists) {
        final cartData = cartSnapshot.data() as Map<String, dynamic>;
        final cartItems = cartData['items'] as List?;

        // Kiểm tra cartItems có null không
        if (cartItems != null) {
          final existingItemIndex = cartItems.indexWhere(
                  (item) => (item as Map<String, dynamic>)['laptop']['id'] == laptop.id);

          if (existingItemIndex != -1) {
            cartItems[existingItemIndex]['quantity'] += quantity;
          } else {
            cartItems.add({'laptop': laptop.toMap(), 'quantity': quantity});
          }

          double newTotalPrice = 0;
          for (var item in cartItems) {
            final laptop = Laptop.fromMap((item as Map<String, dynamic>)['laptop']['id'], (item as Map<String, dynamic>)['laptop']);
            newTotalPrice += laptop.price * (item['quantity'] as int);
          }

          await cartDoc.update({'items': cartItems, 'totalPrice': newTotalPrice});
        } else {
          // cartItems là null, tạo mới
          final double initialTotalPrice = laptop.price * quantity; // Khởi tạo giá ban đầu
          await cartDoc.update({ // Sử dụng update để tạo field items nếu chưa tồn tại
            'items': FieldValue.arrayUnion([{'laptop': laptop.toMap(), 'quantity': quantity}]),
            'totalPrice': initialTotalPrice,
          });
        }
      } else {
        // Giỏ hàng chưa tồn tại, tạo mới
        final double initialTotalPrice = laptop.price * quantity; // Khởi tạo giá ban đầu
        await cartDoc.set({
          'items': [
            {'laptop': laptop.toMap(), 'quantity': quantity}
          ],
          'totalPrice': initialTotalPrice,
        });
      }
    } catch (e) {
      print('Lỗi khi thêm sản phẩm vào giỏ hàng: $e');
    }
  }

  Future<Cart?> getCart() async {
    try {
      final cartDoc = _carts.doc('cart');
      final cartSnapshot = await cartDoc.get();

      if (cartSnapshot.exists) {
        final cartData = cartSnapshot.data() as Map<String, dynamic>;
        final cartItems = cartData['items'] as List?;
        // Kiểm tra cartItems có null không
        if (cartItems != null) {
          final List<CartItem> items = cartItems
              .map((item) => CartItem(
            quantity: (item as Map<String, dynamic>)['quantity'] as int,
            laptop: Laptop.fromMap((item as Map<String, dynamic>)['laptop']['id'] ?? '', (item as Map<String, dynamic>)['laptop'] ?? {}),
          ))
              .toList();
          final double totalPrice = (cartData['totalPrice'] as num?)?.toDouble() ?? 0.0;

          return Cart(items: items, totalPrice: totalPrice);
        } else {
          return Cart(items: [], totalPrice: 0.0); // Trả về giỏ hàng rỗng
        }
      } else {
        return Cart(items: [], totalPrice: 0.0); // Trả về giỏ hàng rỗng
      }
    } catch (e) {
      print('Lỗi khi lấy giỏ hàng: $e');
      return null;
    }
  }

}