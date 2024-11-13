import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/DTO/cart_item_dto.dart';
import '../model/DTO/chitiethoadon_dto.dart';
import '../model/DTO/hoadon_dto.dart';
import '../model/service/hoadon_service.dart';

class hoadonControll{

  Future<void> taoHoaDonVaChiTiet(List<CartItem> cartItems) async {
    try {
      // Tạo ChiTietHoaDon
      final laptops = cartItems.map((item) => item.laptop).toList();
      final tongGia = cartItems.fold(0.0, (sum, item) => sum + (item.laptop.price * item.quantity));
      final chiTietHoaDon = ChiTietHoaDon(laptops: laptops, tongGia: tongGia);

      // Tạo HoaDon
      final hoaDonId = "HD1"; // Tạo ID hóa đơn duy nhất
      final hoaDon = HoaDon(
        id: hoaDonId,
        ngayTao: DateTime.now(),
        chiTiet: chiTietHoaDon,
      );

      // Lưu HoaDon vào Firebase
      final hoaDonService = HoaDonService();
      await hoaDonService.createHoaDon(hoaDon);

      print('Hóa đơn đã được tạo và lưu vào Firebase thành công!');
    } catch (e) {
      print('Lỗi khi tạo hóa đơn: $e');
    }
  }

  static Future<List<HoaDon>> readHoaDons() async {
    final snapshot = await FirebaseFirestore.instance.collection('hoaDons').get();
    return snapshot.docs.map((doc) => HoaDon.fromFirestore(doc)).toList();
  }

}