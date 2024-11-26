import 'package:flutter/material.dart';

class CustomizePage extends StatelessWidget {
  const CustomizePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Your Bouquet')),
      body: const Center(
        child: Text('Customize your flower here!'),
      ),
    );
  }
}
