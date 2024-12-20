import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_laptop_project/controller/lap_controll.dart';
import 'package:new_laptop_project/view/ui/cart_view.dart';
import 'package:new_laptop_project/view/item/laptop_item.dart';
import '../../model/service/laptop_service.dart';

import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      home: const MyHomePage(title: 'Laptop Store'),
      debugShowCheckedModeBanner: false,
    );
  }
}









