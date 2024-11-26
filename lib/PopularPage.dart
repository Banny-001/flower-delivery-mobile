import 'package:bloombox_mobile/ProductDetailPage.dart';
import 'package:bloombox_mobile/notifiers/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularPage extends ConsumerWidget {
  const PopularPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Popular Flowers')),
      body: productsAsync.when(
        data: (products) => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Productdetailpage(product: product),
                ),
              ),
              child: Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      product.image,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('\$${product.price.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
