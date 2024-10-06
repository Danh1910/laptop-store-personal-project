import 'dart:io';

import '../model/DTO/laptop_dto.dart';
import '../model/service/laptop_service.dart';

class lap_controll{
  void themlaptop(){

    final laptopController = laptop_service();
    final newLaptop = Laptop(name: 'Macbook Pro', brand: 'Apple', price: 12500, image: "macbook.jpg");

    laptopController.createLaptop(newLaptop);
  }

  void docdulieu(){
    final laptopController = laptop_service();

    laptopController.getLaptops().then((laptops) {
      for (final laptop in laptops) {
        print('Laptop: ${laptop.name}, ${laptop.brand}, ${laptop.price}, ${laptop.image}');

      }
    });
  }

  Future<List<Laptop>> get_laptop() async {
    final laptopController = laptop_service();
    List<Laptop> laptops = await laptopController.getLaptops();

    return laptops;

  }

  void uploadanh(){
    String imagePath = 'asus_rog.png';
    final laptopController = laptop_service();
// Tạo đối tượng File từ đường dẫn
    File imageFile = File(imagePath);

    print("ảnh là: $imageFile" );

// Gọi hàm uploadImage để tải ảnh lên Firebase Storage
    laptopController.uploadImage(imageFile);
  }

  Future<String> getImageUrl(String imageName) async {
    try {
      final laptopController = laptop_service();
      String imageUrl = await laptopController.getDownloadURL(imageName);
      if (imageUrl.isNotEmpty) {
        return imageUrl;
      } else {
        return ''; // Trả về chuỗi rỗng nếu không cóURL
      }
    } catch (e) {
      print("Lỗi khi lấy link ảnh: $e");
      return ''; // Trả về chuỗi rỗng nếu có lỗi
    }
  }


}