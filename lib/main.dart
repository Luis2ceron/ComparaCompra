import 'package:flutter/material.dart';
import 'package:comparacompra/services/scraper_service.dart';
import 'package:comparacompra/models/category.dart';
import 'package:comparacompra/models/product.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Precio Comparator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Precio Comparator'),
        ),
        body: FutureBuilder(
          future: ScraperService().scrapePrices(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Category>? categories = snapshot.data;
              return ListView.builder(
                itemCount: categories?.length,
                itemBuilder: (context, index) {
                  Category category = categories![index];
                  return Card(
                    child: Column(
                      children: [
                        Text(category.name),
                        ...category.products.map((product) {
                          return ListTile(
                           
                            title: Text(product.name),
                            subtitle: product.stores.isEmpty
                              ? Text('No hay tiendas con precios')
                              : Text('Precio más bajo: ${product.stores.firstWhere((store) => store.price == product.stores.map((store) => store.price).reduce((a, b) => a! < b! ? a : b)).price} en ${product.stores.firstWhere((store) => store.price == product.stores.map((store) => store.price).reduce((a, b) => a! < b! ? a : b)).name}'),
                          );
                          )
                        }),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}