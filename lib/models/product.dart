
import 'package:freezed_annotation/freezed_annotation.dart';
part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product{
  // ignore: prefer_typing_uninitialized_variables
  var price;

  late String name;

  late String image;

  factory Product({
    required String name,
    required String image,
    required double price,
    required String description,
    
  }) =_Product;

  /// Convert a JSON object into an [Activity] instance.
  /// This enables type-safe reading of the API response.
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
