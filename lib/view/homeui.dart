import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/laptop_controller.dart';
import '../model/laptop.dart';
import 'laptop_details.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: const MyHomePage(title: 'Laptop Store'),
      debugShowCheckedModeBanner: false,
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String dulieu = "";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                DSLaptop(),
              ],
            )
        ),
    );
  }
}

class DSLaptop extends StatefulWidget {
  @override
  _DSLaptopState createState() => _DSLaptopState();
}

class _DSLaptopState extends State<DSLaptop> {

  String? _imageUrl; // Biến state để lưu trữ URL ảnh
  List<Laptop> _laptops = [
    Laptop(
        image: 'asus_rog.png',
        brand: 'asus',
        name: 'Asus Rog',
        price: 20000000),

  ];

  // @override
  // void initState() {
  //   super.initState();
  //   _docdulieu(); // Gọi hàm đọc dữ liệu khi widget được khởi tạo
  //   print("init đã chạy.");
  // }

  Future<void> _docdulieu() async {
    final laptopController = LaptopController();
    int i = 0;
    List<Laptop> laptops = await laptopController.getLaptops();
    setState(() {
      _laptops = laptops; // Cập nhật state với danh sách laptop
      i++;
      print("Có ${_laptops.length} laptop");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SizedBox(
          height: 650, // Đặt chiều cao mong muốn
          child: Column(
            children: [
              TextButton(onPressed: themlaptop, child: Text("Thêm lap")),
              TextButton(onPressed: docdulieu, child: Text("Đọc lap")),
              TextButton(onPressed: _docdulieu, child: Text("Đọc firebase")),
              TextButton(
                  onPressed: () => getimage(this), child: Text("Lấy ảnh")),
              Text("Danh sách các sản phẩm laptop"),
              Expanded(
                child: ListView.builder(
                  itemCount: _laptops.length,
                  itemBuilder: (context, index) {
                    Laptop laptop = _laptops[index];
                    return LaptopItem(
                      name: laptop.name,
                      brand: laptop.brand,
                      price: laptop.price,image: laptop.image,
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
}

// if (_imageUrl != null) Image.network(_imageUrl!),

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
        ],
      ),
    );
  }
}

void themlaptop(){

  final laptopController = LaptopController();
  final newLaptop = Laptop(name: 'Laptop Mới', brand: 'Brand A', price: 1500, image: "abc.png");

  laptopController.createLaptop(newLaptop);
}

void docdulieu(){
  final laptopController = LaptopController();

  laptopController.getLaptops().then((laptops) {
    for (final laptop in laptops) {
      print('Laptop: ${laptop.name}, ${laptop.brand}, ${laptop.price}, ${laptop.image}');

    }
  });
}

void uploadanh(){
  String imagePath = 'asus_rog.png';
  final laptopController = LaptopController();
// Tạo đối tượng File từ đường dẫn
  File imageFile = File(imagePath);

  print("ảnh là: $imageFile" );

// Gọi hàm uploadImage để tải ảnh lên Firebase Storage
  laptopController.uploadImage(imageFile);
}

void getimage(_DSLaptopState state) async {
  final laptopController = LaptopController();
  try {
    String imageUrl = await laptopController.getDownloadURL();
    if (imageUrl.isNotEmpty) {
      print("Đã có link ảnh: $imageUrl");
      // Hiển thị ảnh
      state.setState(() {
        // state.chuoividu = "ảnh msi";
        state._imageUrl = imageUrl;
      });
    } else {
      print("Chưa có link ảnh");
    }
  } catch (e) {
    print("Lỗi khi lấy link ảnh: $e");
  }
}