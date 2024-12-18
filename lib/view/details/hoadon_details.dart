
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_laptop_project/model/DTO/hoadon_dto.dart';

import '../../model/DTO/laptop_dto.dart';

class HoaDonDetails extends StatelessWidget{

  final HoaDon hoaDon;

  HoaDonDetails( {
    super.key,
    required this.hoaDon,
  });


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết hóa đơn'),
      ),
      body: Center(
        child: Column(
          children: [
            _buildHoaDonInfo(),
            ...hoaDon.chiTiet.laptops.map((laptop){
              return _buil_item_laptop(laptop);
              }
            ),
            _buildThanhToanInfo()
          ],
        ),
      ),
    );
  }

  Widget _buil_item_laptop(Laptop laptop){
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Căn chỉnh các widget cách đều nhau
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/${laptop.image}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 16), // Khoảng cách giữa ảnh và thông tin
                      Expanded( // Expanded để thông tin chiếm không gian còn lại
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(laptop.name),
                            SizedBox(height: 50),
                            Align( // Căn chỉnh giá sản phẩm sang phải
                              alignment: Alignment.bottomRight,
                              child: Text('Giá: ${laptop.price}'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            )
        ),
      ],
    );
  }

  Widget _buildHoaDonInfo() {
    return SizedBox(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Laptop Store",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 8,),
                Text("Đặt hàng thành công"),
                SizedBox(height: 5,),
                Text("Mã đơn hàng: " + hoaDon.id),
                SizedBox(height: 5,),
                Text("Thời gian đặt hàng: ${hoaDon.ngayTao}")
              ],
            ),
          ),
        )
    );
  }


  Widget _buildThanhToanInfo() {
    return SizedBox(
        width: double.infinity,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Thanh toán", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: Text("Phương thức thanh toán:")),
                      Text("Tiền mặt")
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: Text("Tổng tiền:  ")),
                      Text("${hoaDon.chiTiet.tongGia}")
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }


}