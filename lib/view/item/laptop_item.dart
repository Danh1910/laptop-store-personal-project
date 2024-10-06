import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../details/laptop_details.dart';

class LaptopItem extends StatelessWidget{

  const LaptopItem({
    Key? key,
    required this.name,
    required this.brand,
    required this.price,
    required this.image,
    this.imageUrl, // Thêm imageUrl vào constructor
  }) : super(key: key);

  final String name;
  final String brand;
  final int price;
  final String image;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => LaptopDetailsScreen(
                imagePath: image,
                name: name,price: price, brand: brand
            ),
          ),
        );
      },
      child: Column(
        children: [
          if (imageUrl != null) // Kiểm tra nếu imageUrl khác null
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network( // Sử dụng Image.network để hiển thị ảnh từ URL
                imageUrl!,
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),
            )
          else
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset( // Sử dụng Image.asset nếu imageUrl là null
                "assets/$image",
                width:180,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          Text(name),
          Text(price.toString()),
          ElevatedButton(
            onPressed: () {
              // Xử lý sự kiện khi nút mua được nhấn
            },
            child: const Text('Mua'),
          ),
        ],
      ),
    );
  }
}