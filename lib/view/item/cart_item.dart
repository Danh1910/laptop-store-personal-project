import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItemUI extends StatelessWidget{
  const CartItemUI({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.grey[300],
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        height: 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Căn lề trên cho các item trong Row
              children: [
                Image.asset(
                  "assets/lenovo.jpg",
                  width: 120,
                  height: 140,
                ),
                SizedBox(width: 16.0), // Khoảng cáchgiữa ảnh và cột thông tin
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ten"),
                    SizedBox(height: 16.0,),
                    Text("Gia"),
                    SizedBox(height: 16.0,),
                    Text("So luong"),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                TextButton(
                    onPressed: nhan, child: Text("giảm"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)
                  ),
                ),
                SizedBox(width: 8.0), // Khoảng cách giữa 2 button
                TextButton(onPressed: nhan, child: Text("tăng"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)
                  ),)
              ],
            ),
          ],
        ),
      ),

    );
  }

  void nhan(){
    print("nhấn");
  }

}