import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'laptop_details.dart';

class LaptopItem extends StatelessWidget{

  const LaptopItem({
    super.key,
    required this.name,
    required this.brand,
    required this.price,
    required this.image,

  });

  final String name;
  final String brand;
  final int price;
  final String image;

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
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/$image",
              width: 180,
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