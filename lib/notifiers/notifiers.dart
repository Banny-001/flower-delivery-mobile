
import 'dart:convert';
import 'package:bloombox_mobile/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';


// Define the product provider
final productProvider = FutureProvider<List<Product>>((ref) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/products'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data.map((e) => Product.fromJson(e)).toList();
  } else {
    throw Exception('Failed to fetch products');
  }
});


