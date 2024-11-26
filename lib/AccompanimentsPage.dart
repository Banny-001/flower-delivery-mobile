import 'package:bloombox_mobile/AccompanimentDetailPage.dart';
import 'package:flutter/material.dart';
import '../models/accompaniment.dart'; // Adjust the import based on your folder structure
// import 'accompaniment_detail_page.dart'; // Adjust the import based on your folder structure

class AccompanimentsPage extends StatefulWidget {
  const AccompanimentsPage({Key? key}) : super(key: key);

  @override
  _AccompanimentsPageState createState() => _AccompanimentsPageState();
}

class _AccompanimentsPageState extends State<AccompanimentsPage> {
  // Sample list of accompaniments
  final List<Accompaniment> accompaniments = [
    Accompaniment(
      name: 'Wine',
      imageUrl: 'assets/images/wine.jpg', // Replace with your image asset
      price: 15.99,
      description: 'A bottle of fine wine.',
    ),
    Accompaniment(
      name: 'Chocolates',
      imageUrl: 'assets/images/chocolates.jpg', // Replace with your image asset
      price: 9.99,
      description: 'A box of assorted chocolates.',
    ),
    // Add more accompaniments here
  ];

  void _onAccompanimentTap(Accompaniment accompaniment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccompanimentDetailPage(accompaniment: accompaniment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accompaniments')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(10),
        itemCount: accompaniments.length,
        itemBuilder: (context, index) {
          final accompaniment = accompaniments[index];

          return GestureDetector(
            onTap: () => _onAccompanimentTap(accompaniment),
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      accompaniment.imageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    accompaniment.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('\$${accompaniment.price.toStringAsFixed(2)}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
