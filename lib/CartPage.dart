import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Center(
        child: Text(
          'Cart Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );

}
}