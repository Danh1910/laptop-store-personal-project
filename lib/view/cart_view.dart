import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Giỏ hàng")
          ],
        ),
      ),
    );
  }
}