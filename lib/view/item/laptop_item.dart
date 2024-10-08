import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_laptop_project/model/DTO/laptop_dto.dart';

import '../details/laptop_details.dart';

class LaptopItem extends StatelessWidget{

  final Laptop laptop;

  const LaptopItem({
    Key? key,
    this.imageUrl,
    required this.laptop,
  }) : super(key: key);


  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => LaptopDetailsScreen(
                imagePath: laptop.image,
                laptop: laptop,
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
                "assets/${laptop.image}",
                width:180,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          Text(laptop.name),
          Text(laptop.price.toString()),
          Text(laptop.id)

        ],
      ),
    );
  }
}