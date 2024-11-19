import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:new_laptop_project/model/service/Firebase_service.dart';

import '../../controller/cart_controll.dart';
import '../../model/DTO/laptop_dto.dart';
import '../../model/service/laptop_service.dart';
import '../../controller/lap_controll.dart';

import '../item/laptop_item.dart';

class DSLaptop extends StatefulWidget {
  @override
  _DSLaptopState createState() => _DSLaptopState();
}

class _DSLaptopState extends State<DSLaptop> {

  String? _imageUrl; // Biến state để lưu trữ URL ảnh
  final lapct = Get.put(lap_controll());


  List<Laptop> _laptops = [];

  @override
  void initState() {
    super.initState();

    _docdulieu(); // Gọi hàm đọc dữ liệu khi widget được khởi tạo
    print("init đã chạy.");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SizedBox(height: 650, // Đặt chiều cao mong muốn
          child: Column(
            children: [
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
                          // if (_imageUrl != null) Image.network(_imageUrl!),
                          if (firstIndex < _laptops.length)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0), // Padding giữa các item
                                child: LaptopItem(
                                  imageUrl: _laptops[firstIndex].imageUrl,
                                  laptop: _laptops[firstIndex],

                                ),
                              ),
                            ),
                          if (secondIndex < _laptops.length)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0), // Padding giữa các item
                                child: LaptopItem(
                                  imageUrl: _laptops[secondIndex].imageUrl,
                                  laptop: _laptops[secondIndex],
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

  Future<void> _docdulieu() async {
    List<Laptop> laptops = await lapct.getLaptopObjects();
    setState(() {
      _laptops = laptops;
      for (var laptop in _laptops) {
        _getImageForLaptop(laptop);
      }
    });
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




