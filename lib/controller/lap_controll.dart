import 'dart:io';

import '../model/laptop.dart';
import 'firebase_service.dart';

class lap_controll{
  void themlaptop(){

    final laptopController = firebasecontroll();
    final newLaptop = Laptop(name: 'Laptop Mới', brand: 'Brand A', price: 1500, image: "asus.png");

    laptopController.createLaptop(newLaptop);
  }

  void docdulieu(){
    final laptopController = firebasecontroll();

    laptopController.getLaptops().then((laptops) {
      for (final laptop in laptops) {
        print('Laptop: ${laptop.name}, ${laptop.brand}, ${laptop.price}, ${laptop.image}');

      }
    });
  }

  void uploadanh(){
    String imagePath = 'asus_rog.png';
    final laptopController = firebasecontroll();
// Tạo đối tượng File từ đường dẫn
    File imageFile = File(imagePath);

    print("ảnh là: $imageFile" );

// Gọi hàm uploadImage để tải ảnh lên Firebase Storage
    laptopController.uploadImage(imageFile);
  }
}