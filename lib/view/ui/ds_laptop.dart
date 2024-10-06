import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/firebase_service.dart';
import '../../controller/lap_controll.dart';
import '../../model/laptop.dart';
import '../item/laptop_item.dart';

class DSLaptop extends StatefulWidget {
  @override
  _DSLaptopState createState() => _DSLaptopState();
}

class _DSLaptopState extends State<DSLaptop> {

  String? _imageUrl; // Biến state để lưu trữ URL ảnh
  final lapct = new lap_controll();

  List<Laptop> _laptops = [];

  @override
  void initState() {
    super.initState();
    _docdulieu(); // Gọi hàm đọc dữ liệu khi widget được khởi tạo
    print("init đã chạy.");
  }

  Future<void> _docdulieu() async {
    final laptopController = firebasecontroll();
    List<Laptop> laptops = await laptopController.getLaptops();
    setState(() {
      _laptops = laptops;
      for (var laptop in _laptops) {
        _getImageForLaptop(laptop);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SizedBox(height: 650, // Đặt chiều cao mong muốn
          child: Column(
            children: [
              // TextButton(onPressed: lapct.themlaptop, child: Text("Thêm lap")),
              // TextButton(onPressed: lapct.docdulieu, child: Text("Đọc lap")),
              TextButton(onPressed: _docdulieu, child: Text("Đọc firebase")),
                  // TextButton(onPressed: () => getimage("msi.jpg"), child: Text("Lấy ảnh")),
              Expanded(
                child: ListView.builder(
                  itemCount: (_laptops.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    int firstIndex = index * 2;
                    int secondIndex = index * 2 + 1;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding giữa các hàng
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Canh giữa các item
                        children: [
                          if (_imageUrl != null) Image.network(_imageUrl!),
                          if (firstIndex < _laptops.length)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0), // Padding giữa các item
                                child: LaptopItem(
                                  name: _laptops[firstIndex].name,
                                  brand: _laptops[firstIndex].brand,
                                  price: _laptops[firstIndex].price,
                                  image: _laptops[firstIndex].image,
                                  imageUrl: _laptops[firstIndex].imageUrl,
                                ),
                              ),
                            ),
                          if (secondIndex < _laptops.length)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0), // Padding giữa các item
                                child: LaptopItem(
                                  name: _laptops[secondIndex].name,
                                  brand: _laptops[secondIndex].brand,
                                  price: _laptops[secondIndex].price,
                                  image: _laptops[secondIndex].image,
                                  imageUrl: _laptops[secondIndex].imageUrl,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _getImageForLaptop(Laptop laptop) async {
    String imageUrl = await lapct.getImageUrl(laptop.image);
    if (imageUrl.isNotEmpty) {
      setState(() {
        laptop.imageUrl = imageUrl;
      });
    }
  }
}



