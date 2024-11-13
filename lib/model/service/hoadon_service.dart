import 'package:cloud_firestore/cloud_firestore.dart';

import '../DTO/hoadon_dto.dart';

class HoaDonService {
  final CollectionReference hoaDons = FirebaseFirestore.instance.collection(
      'hoaDons');

  Future<void> createHoaDon(HoaDon hoaDon) async {
    try {
      await hoaDons.add(hoaDon.toMap());
      print('Hóa đơn đã được thêm vào Firestore thành công!');
    } catch (e) {
      print('Lỗi khi tạo hóa đơn: $e');
    }
  }
}