import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/DTO/cart_item_dto.dart';
import '../model/DTO/chitiethoadon_dto.dart';
import '../model/DTO/hoadon_dto.dart';
import '../model/service/hoadon_service.dart';

class hoadonControll extends GetxController{

  final HoaDonService _hoaDonService = HoaDonService();
  String? userId; // Khai báo userId


  @override
  Future<void> onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
  }

  Future<void> taoHoaDonVaChiTiet(List<CartItem> cartItems) async {
    try {
      // Tạo ChiTietHoaDon
      final laptops = cartItems.map((item) => item.laptop).toList();
      final tongGia = cartItems.fold(0.0, (sum, item) => sum + (item.laptop.price * item.quantity));
      final chiTietHoaDon = ChiTietHoaDon(laptops: laptops, tongGia: tongGia);

      // Tạo HoaDon
      final hoaDon = HoaDon(
        id: '', // Để trống id, Firestore sẽ tự động tạo
        ngayTao: DateTime.now(),
        chiTiet: chiTietHoaDon,
      );

      // Lưu HoaDon vào Firebase
      final hoaDonService = HoaDonService();
      await hoaDonService.createHoaDon(hoaDon, userId!);

      print('Hóa đơn đã được tạo và lưu vào Firebase thành công!');
    } catch (e) {
      print('Lỗi khi tạo hóa đơn: $e');
    }
  }

  static Future<List<HoaDon>> readHoaDonsByUserId(String userId)async {
    final snapshot = await FirebaseFirestore.instance
        .collection('hoaDons')
        .where('userId', isEqualTo: userId) // Thêm điều kiện userId
        .get();
    return snapshot.docs.map((doc) => HoaDon.fromFirestore(doc)).toList();
  }

}