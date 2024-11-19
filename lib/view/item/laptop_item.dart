import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final formatter = NumberFormat("#,##0");
    final formattedPrice = formatter.format(laptop.price);
    final formattedPrice2 = formatter.format(laptop.original_price);

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
      child: Card(
        shape: RoundedRectangleBorder( // Bo cong cho Card
          borderRadius: BorderRadius.circular(10),

        ),
        color: Colors.white,
        child: Padding(padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Căn chỉnh các widget con sang trái
            children: [
              if (imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl!,
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/${laptop.image}",
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 8), // Khoảng cách giữa ảnh và tên
              Text(laptop.name),
              Text(
                formattedPrice2+"đ",
                style: TextStyle(
                    color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                formattedPrice+"đ",
                style: TextStyle(color: Colors.blue),
              ),
              // Text(laptop.id),
            ],
          ),
        ),
      )
    );
  }
}