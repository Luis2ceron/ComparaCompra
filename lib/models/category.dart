import 'package:comparacompra/models/product.dart';

class Category {
  final String name;
  final List<Product> products;

  Category({required this.name, required this.products});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
    );
  }
}