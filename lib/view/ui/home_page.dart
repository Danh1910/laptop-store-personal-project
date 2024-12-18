import 'package:flutter/material.dart';
import 'package:new_laptop_project/view/ui/sign_in.dart';
import 'package:new_laptop_project/view/ui/sign_up.dart';

import 'cart_view.dart';
import 'ds_hoadon.dart';
import 'ds_laptop.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dulieu = "";
  int _selectedIndex = 0;

  Widget? widget_temp_dslaptop;
  Widget? widget_temp_dshd;

  Widget? widget_temp;

  static final List<Widget> _widgetOptions = <Widget>[
    DSLaptop(),
    DSHoaDon(),
    Sign_up(),
    Sign_in(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          widget_temp_dslaptop ??= DSLaptop(); // Khởi tạo nếuchưa tồn tại
          widget_temp = widget_temp_dslaptop!;
          break;
        case 1:
          widget_temp_dshd ??= DSHoaDon(); // Khởi tạo nếu chưa tồn tại
          widget_temp = widget_temp_dshd!;
          break;
        default:
          widget_temp = _widgetOptions.elementAt(_selectedIndex);
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
            widget.title,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartView())
              );
            },
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex), // Hiển thị widget tương ứng
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Sản phẩm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Hóa đơn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Đăng ký',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Đăng nhập',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped, // Gọi hàm _onItemTapped khi người dùng nhấn vào tab
      ),
    );
  }
}