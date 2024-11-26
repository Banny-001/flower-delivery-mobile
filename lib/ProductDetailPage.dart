import 'dart:core';

import 'package:bloombox_mobile/CustomizePage.dart';
import 'package:bloombox_mobile/models/product.dart';
import 'package:flutter/material.dart';

class Productdetailpage extends StatefulWidget {
  final Product product;

  // ignore: use_super_parameters
  const Productdetailpage({Key? key, required this.product}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductdetailpageState createState() => _ProductdetailpageState();
}

class _ProductdetailpageState extends State<Productdetailpage> {
  int _quantity = 1; // Initialize quantity to 1

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void _addToCart() {
    // Logic to add the flower to the cart
    // You may need to implement a cart provider or similar state management solution
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.product} added to cart!'),
        backgroundColor: Colors.red, // Set background color to red
        behavior: SnackBarBehavior.floating, // SnackBar floats above content
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height -
                200), // Position at the top
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product as String)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.product as String,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              widget.product as String,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // const SizedBox(height: 8),
            // Text(
            //   '\$${widget.product.double.toStringAsFixed(2)}',
            //   style: const TextStyle(fontSize: 20),
            // ),
            // const SizedBox(height: 16),
            // Text(
            //   widget.product.description,
            //   style: const TextStyle(fontSize: 16),
            // ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: _decreaseQuantity,
                    ),
                    Text(
                      '$_quantity',
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _increaseQuantity,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _addToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red, // Set the background color to red
                  ),
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to CustomizePage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomizePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 215, 210, 224),
             
              ),
              child: const Text('Customize'),
             
            ),
          ],
        ),
      ),
    );
  }
}
