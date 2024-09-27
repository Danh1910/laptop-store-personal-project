import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/laptop.dart';

class LaptopController {
  final CollectionReference laptops = FirebaseFirestore.instance.collection('laptops');

  Future<void> createLaptop(Laptop laptop) async {try {
    await laptops.add(laptop.toMap());
    print('Laptop đã được thêm vào Firestore thành công!'); // Dòng print mới
  } catch (e) {
    print('Lỗi khi tạo laptop: $e');
  }
  }


  Future<List<Laptop>> getLaptops() async {
    try {
      final QuerySnapshot snapshot = await this.laptops.get(); // Sử dụng this.laptops
      final List<Laptop> laptopList = snapshot.docs.map((doc) { // Đổi tên biến local
        return Laptop.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
      return laptopList;
    } catch (e) {
      print('Lỗi khi lấy danh sách laptop: $e');
      print("lỗi");
      print("commit4")
      return [];
    }
  }
}