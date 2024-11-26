
// import 'dart:convert';
// import 'package:bloombox_mobile/models/product.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:riverpod_annotation/riverpod_annotation.dart';


// // Necessary for code-generation to work
// part '../product.g.dart';

// /// This will create a provider named `activityProvider`
// /// which will cache the result of this function.
// @riverpod
// Future<Product> product(Ref ref) async {
//   final response = await http.get(Uri.https('http://127.0.0.1:8000/api/products'));
//   final json = jsonDecode(response.body) as Map<String, dynamic>;
//   return Product.fromJson(json);
// }