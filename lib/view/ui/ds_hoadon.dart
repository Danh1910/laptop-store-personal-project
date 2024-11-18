import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_laptop_project/controller/hoadon_controller.dart';
import 'package:new_laptop_project/model/DTO/hoadon_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DSHoaDon extends StatefulWidget {
  @override
  _DSHoaDonState createState() => _DSHoaDonState();
}

class _DSHoaDonState extends State<DSHoaDon> {
  final hoaDonControll = Get.put(hoadonControll());
  List<HoaDon> _hoaDons = [];

  @override
  void initState() {
    super.initState();
    _docdulieu(); // Gọi hàm đọc dữ liệu khi widget được khởi tạo
    print("hóa đơn đã chạy.");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SizedBox(
          height: 650, // Đặt chiều cao mong muốn
          child: Column(
            children: [
              TextButton(
                  onPressed: _docdulieu, child: Text("Đọc firebase")),
              Expanded(
                child: ListView.builder(
                  itemCount: _hoaDons.length,
                  itemBuilder: (context, index) {
                    final hoaDon = _hoaDons[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Bo góc 10.0
                      ),
                      color:Colors.white, // Màu nền trắng
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hóa đơn ${hoaDon.id}', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Ngày tạo: ${hoaDon.ngayTao}'),
                            // Hiển thị danh sách laptop trong chi tiết hóa đơn
                            ...hoaDon.chiTiet.laptops.map((laptop) {
                              return Row(
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
                                        Text(laptop.name, style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text('Giá: ${laptop.price}'),
                                        // Text('Số lượng: ${laptop.soLuong}'), // Thêm số lượng nếu cần
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                            SizedBox(height: 16), // Khoảng cách giữa danh sách laptop và tổng tiền
                            Align( // Align để căn chỉnh tổng tiềnở góc dưới bên phải
                              alignment: Alignment.bottomRight,
                              child: Text('Tổng tiền: ${hoaDon.chiTiet.tongGia}', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _docdulieu() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId;
    userId = prefs.getString('userId');
    List<HoaDon> hoaDons = await hoadonControll.readHoaDonsByUserId(userId!);
    setState(() {
      _hoaDons = hoaDons;
    });
  }
}