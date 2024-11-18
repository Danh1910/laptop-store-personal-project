import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_laptop_project/model/DTO/cart_dto.dart';

import '../DTO/cart_item_dto.dart';
import '../DTO/laptop_dto.dart';
import 'account_service.dart';

class CartService {
  final CollectionReference _carts = FirebaseFirestore.instance.collection('carts');

  final AccountService _accountService = AccountService();


  Future<void> addToCart(Laptop laptop, int quantity, String userId) async {
    try {
      final cartDoc = _carts.doc(userId); // Sử dụng userId làm documentId
      final cartSnapshot = await cartDoc.get();

      if (cartSnapshot.exists) {
        //Giỏ hàng đã tồn tại, cập nhật giỏ hàng
        final cartData = cartSnapshot.data() as Map<String, dynamic>;
        final cartItems = cartData['items'] as List?;

        if (cartItems != null) {
          // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
          final existingItemIndex = cartItems.indexWhere(
                  (item) => (item as Map<String, dynamic>)['laptop']['id'] == laptop.id);

          if (existingItemIndex != -1) {
            // Sản phẩm đã cótrong giỏ hàng, tăng số lượng
            cartItems[existingItemIndex]['quantity'] += quantity;
          } else {
            // Sản phẩm chưa có trong giỏ hàng, thêm mới
            cartItems.add({'laptop': laptop.toMap(), 'quantity': quantity});
          }

          // Tính toán lại tổng giá
          double newTotalPrice = 0;
          for (var item in cartItems) {
            final laptop = Laptop.fromMap((item as Map<String, dynamic>)['laptop']['id'], (item as Map<String, dynamic>)['laptop']);
            newTotalPrice += laptop.price * (item['quantity'] as int);
          }

          // Cập nhật giỏ hàng trên Firestore
          await cartDoc.update({'items': cartItems, 'totalPrice': newTotalPrice});
        } else {
          // cartItems là null, tạo mới
          final double initialTotalPrice = laptop.price * quantity;
          await cartDoc.update({
            'items': FieldValue.arrayUnion([{'laptop': laptop.toMap(), 'quantity': quantity}]),
            'totalPrice': initialTotalPrice,
          });
        }
      } else{
        // Giỏ hàng chưa tồn tại, tạo mới giỏ hàng
        final double initialTotalPrice = laptop.price * quantity;
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

  Future<Cart?>getCart(String userId) async {
    try {
      final cartDoc = _carts.doc(userId); // Sử dụng userId làm documentId
      final cartSnapshot = await cartDoc.get();

      if (cartSnapshot.exists) {
        final cartData = cartSnapshot.data() as Map<String, dynamic>;
        final cartItems = cartData['items'] as List?;

        if (cartItems != null) {
          final List<CartItem> items = cartItems
              .map((item) => CartItem(
            quantity: (item as Map<String, dynamic>)['quantity'] as int,
            laptop: Laptop.fromMap((item as Map<String, dynamic>)['laptop']['id'] ?? '', (item as Map<String, dynamic>)['laptop'] ?? {}),
          ))
              .toList();
          final double totalPrice =(cartData['totalPrice'] as num?)?.toDouble() ?? 0.0;

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