import 'package:bloombox_mobile/CustomizePage.dart'; // Import CustomizePage
import 'package:bloombox_mobile/models/accompaniment.dart';
import 'package:flutter/material.dart';

class AccompanimentDetailPage extends StatefulWidget {
  final Accompaniment accompaniment;

  const AccompanimentDetailPage({Key? key, required this.accompaniment}) : super(key: key);

  @override
  _AccompanimentDetailPageState createState() => _AccompanimentDetailPageState();
}

class _AccompanimentDetailPageState extends State<AccompanimentDetailPage> {
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
    // Logic to add the accompaniment to the cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.accompaniment.name} added to cart!'),
        backgroundColor: Colors.red, // Set background color to red
        behavior: SnackBarBehavior.floating, // SnackBar floats above content
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 200), // Position at the top
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.accompaniment.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.accompaniment.imageUrl), // Display the image
            const SizedBox(height: 16),
            Text(
              widget.accompaniment.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${widget.accompaniment.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              widget.accompaniment.description,
              style: const TextStyle(fontSize: 16),
            ),
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
                    backgroundColor: Colors.red, // Set the background color to red
                  ),
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
