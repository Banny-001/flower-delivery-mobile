import 'package:flutter/material.dart';

class Orderspage extends StatefulWidget {
  const Orderspage({super.key});

  @override
  State<Orderspage> createState() => _OrderspageState();
}

class _OrderspageState extends State<Orderspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Orders Page'),
      ),
      body: Center(
        child: Text(
          'Orders Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}