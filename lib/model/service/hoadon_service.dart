import 'package:cloud_firestore/cloud_firestore.dart';

import '../DTO/hoadon_dto.dart';

class HoaDonService {
  final CollectionReference hoaDons = FirebaseFirestore.instance.collection('hoaDons');

  Future<void> createHoaDon(HoaDon hoaDon, String userId) async {
    try {
      final newHoaDonRef = hoaDons.doc(); // Tạo document mới với ID tự động
      final hoaDonId = newHoaDonRef.id; // Lấy ID của document mới
      hoaDon.id = hoaDonId; // Gán ID cho đối tượng HoaDon

      await newHoaDonRef.set({
        ...hoaDon.toMap(), // Sử dụng toMap() của HoaDon
        'userId': userId, // Thêm trường userId
      });

      print('Hóa đơn đãđược thêm vào Firestore thành công!');
    } catch (e) {
      print('Lỗi khi tạo hóa đơn: $e');
    }
  }
}