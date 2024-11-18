import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_dto.dart';
import 'chitiethoadon_dto.dart';
import 'laptop_dto.dart';


class HoaDon {
  String id; // ID hóa đơn
  final DateTime ngayTao; // Ngày tạo hóa đơn
  final ChiTietHoaDon chiTiet; // Chi tiết hóa đơn

  HoaDon({
    this.id = '',
    required this.ngayTao,
    required this.chiTiet,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ngayTao': ngayTao,
      'chiTiet': chiTiet.toMap(), // Gọi toMap của ChiTietHoaDon
    };}

  factory HoaDon.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Chuyển đổi dữ liệu từ Firestore sang HoaDon
    return HoaDon(
      id: doc.id,
      ngayTao: (data['ngayTao'] as Timestamp).toDate(),
      chiTiet: ChiTietHoaDon.fromMap(data['chiTiet']),
    );
  }
}