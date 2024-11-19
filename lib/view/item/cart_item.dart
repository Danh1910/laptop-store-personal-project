import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/DTO/cart_item_dto.dart';

class CartItemUI extends StatelessWidget{
  const CartItemUI({super.key, required this.item, required this.onIncrement, required this.onDecrement});

  final CartItem item;
  final Function() onIncrement; // Hàm cho nút tăng
  final Function() onDecrement;

  @override
  Widget build(BuildContext context) {

    final formatter = NumberFormat("#,##0");
    final formattedPrice = formatter.format(item.laptop.price);

    return Card(
      shape: RoundedRectangleBorder( //Bo cong cho Card
        borderRadius: BorderRadius.circular(10), // Điều chỉnh độ cong
      ),
        color: Colors.white,
       margin: EdgeInsets.all(5),
       child: GestureDetector(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            height: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Căn lề trên cho các item trong Row
                  children: [
                    Image.asset(
                      "assets/${item.laptop.image}",
                      width: 120,
                      height: 140,
                    ),
                    SizedBox(width: 16.0), // Khoảng cách giữa ảnh và cột thông tin
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.laptop.name),
                        SizedBox(height: 16.0,),
                        Text(formattedPrice+"đ"),
                        SizedBox(height: 16.0,),
                        Text(item.quantity.toString()),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: onDecrement, child: Text("-"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                            minimumSize: MaterialStateProperty.all<Size>(Size(40, 40)), // Điều chỉnh chiều rộng và chiều cao
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(width: 4.0), // Khoảng cách giữa 2 button
                        TextButton(onPressed: onIncrement, child: Text("+"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                            minimumSize: MaterialStateProperty.all<Size>(Size(40, 40)),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),

                          ),
                        ),
                      ],
                    ),
                    TextButton(onPressed: nhan, child: Text("Xóa"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                        minimumSize: MaterialStateProperty.all<Size>(Size(40, 40)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),

                      ),
                    ),
                  ],
                )

              ],
            ),
          ),

        )
    );


  }

  void nhan(){
    print("nhấn");
  }

}