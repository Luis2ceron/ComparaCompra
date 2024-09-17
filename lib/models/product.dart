class Product {
  final String name;
  final String category;
  final List<Store> stores;

  Product({required this.name, required this.category, required this.stores});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      category: json['category'],
      stores: (json['stores'] as List)
          .map((store) => Store.fromJson(store))
          .toList(),
    );
  }
}

class Store {
  final String name;
  final String url;
  final double? price;

  Store({required this.name, required this.url, required this.price});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      name: json['name'],
      url: json['url'],
      price: json['price'],
    );
  }
}