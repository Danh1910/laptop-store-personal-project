import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/laptop.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class firebasecontroll {
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
      return [];
    }
  }

  Future<void> uploadImage(File imageFile) async {
    try {
      // Khởi tạo Firebase Storage
      firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

      // Tạo tham chiếu đến vị trí lưu trữ
      firebase_storage.Reference ref = storage.ref().child('${DateTime.now().toString()}'); // Sử dụng timestamp để tạo tên file duy nhất

      // Tải ảnh lên
      firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);

      // Theo dõi tiến độ (tùy chọn)
      uploadTask.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
        print('Uploaded ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
      });

      // Lấy download URL sau khi tải lên thành công
      await uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        print('Download URL: $downloadURL');

      });
    } on firebase_storage.FirebaseException catch (e) {
      print('Lỗikhi tải ảnh lên: ${e.code}');
    }
  }

  Future<String> getDownloadURL() async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('msi.jpg'); // Thay 'images/asus_rog.png' bằng đường dẫn đến ảnh của bạn
    String downloadURL = await ref.getDownloadURL();
    if (downloadURL == null) {
      print("Link ảnh null");
      throw Exception("Link ảnh null");
    } else {
      return downloadURL;
    }

  }

}