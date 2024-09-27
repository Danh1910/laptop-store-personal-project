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

class DSLaptop extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: const Column(
            children: [
              TextButton(onPressed: themlaptop, child: Text("Thêm lap")),
              Text("Danh sách các sản phẩm laptop"),
              Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 30,
                  children: [
                    LaptopItem(imagePath: 'assets/asus_rog.png', name: 'Asus Rog', price: "20,000,000"),
                    LaptopItem(imagePath: 'assets/asus_rog.png', name: 'Asus Rog1', price: "21,000,000"),
                    LaptopItem(imagePath: 'assets/asus_rog.png', name: 'Asus Rog2', price: "19,000,000"),
                    LaptopItem(imagePath: 'assets/asus_rog.png', name: 'Asus Rog2', price: "18,000,000"),
                  ]
              ),
            ],
          )
          
        ),
    );
  }

}

class LaptopItem extends StatelessWidget{



  const LaptopItem({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
  });

  final String imagePath;
  final String name;
  final String price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => LaptopDetailsScreen(
            imagePath: imagePath,
            name: name,price: price,
          ),
        ),
      );
    },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              width: 180,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          Text(name),
          Text(price),
        ],
      ),
    );
  }
}

void themlaptop(){

  final laptopController = LaptopController();
  final newLaptop = Laptop(name: 'Laptop Mới', brand: 'Brand A', price: 1500);

  laptopController.createLaptop(newLaptop);
}

void docdulieu(){
  final laptopController = LaptopController();

  laptopController.getLaptops().then((laptops) {
    for (final laptop in laptops) {
      print('Laptop: ${laptop.name}, ${laptop.brand}, ${laptop.price}');
    }
  });
}