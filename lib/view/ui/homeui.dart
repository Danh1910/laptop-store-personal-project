import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_laptop_project/controller/lap_controll.dart';
import 'package:new_laptop_project/view/ui/cart_view.dart';
import 'package:new_laptop_project/view/item/laptop_item.dart';
import '../../controller/firebase_service.dart';
import '../../model/laptop.dart';
import 'home_page.dart';

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









