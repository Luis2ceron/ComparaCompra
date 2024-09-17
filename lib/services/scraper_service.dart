import 'package:comparacompra/models/category.dart';
import 'package:comparacompra/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class ScraperService {
  Future<List<Category>> scrapePrices() async {
    final categories = <Category>[];

    // Categoría "Canasta Básica"
    final canastaBasica = Category(name: 'Canasta Básica', products: []);

    // Huevos
    final huevos = Product(
      name: 'Huevos',
      category: 'Canasta Básica',
      stores: [
        Store(name: 'Metro', url: 'https://www.tiendasmetro.co/huevos-kikes-rojo-tipo-aa-x30und/p', price:  await _scrapePrice('https://www.tiendasmetro.co/huevos-kikes-rojo-tipo-aa-x30und/p')),
        Store(name: 'Jumbo', url: 'https://www.tiendasjumbo.co/huevos-kikes-rojo-tipo-aa-x30und/p', price: await _scrapePrice('https://www.tiendasjumbo.co/huevos-kikes-rojo-tipo-aa-x30und/p')),
        Store(name: 'Éxito', url: 'https://www.exito.com/huevo-aa-rojo-30und-pet-744836/p', price: await _scrapePrice('https://www.exito.com/huevo-aa-rojo-30und-pet-744836/p')),
      ],
    );
    canastaBasica.products.add(huevos);

    // Leche
    final leche = Product(
      name: 'Leche',
      category: 'Canasta Básica',
      stores: [
         Store(name: 'Metro', url: 'https://www.tiendasmetro.co/leche-entera-bolsa-x-1100-x-6und-colanta/p', price:await _scrapePrice('https://www.tiendasmetro.co/leche-entera-bolsa-x-1100-x-6und-colanta/p')),
        Store(name: 'Jumbo', url: 'https://www.tiendasjumbo.co/leche-entera-bolsa-x-1100-x-6und-colanta/p', price: await _scrapePrice('https://www.tiendasjumbo.co/leche-entera-bolsa-x-1100-x-6und-colanta/p')),
        Store(name: 'Éxito', url: 'https://www.exito.com/leche-uht-entera-colanta-6000-ml-3069107/p', price: await _scrapePrice('https://www.exito.com/leche-uht-entera-colanta-6000-ml-3069107/p')),
      ],
    );
    canastaBasica.products.add(leche);

    categories.add(canastaBasica);

    // Categoría "Aseo"
    final aseo = Category(name: 'Aseo', products: []);

    // Limpia Pisos
    final limpiaPisos = Product(
      name: 'Limpia Pisos',
      category: 'Aseo',
      stores: [
         Store(name: 'Metro', url: 'https://www.tiendasmetro.co/limpia-pisos-fabuloso-antibacterial-lavanda-3l/p', price: await _scrapePrice('https://www.tiendasmetro.co/limpia-pisos-fabuloso-antibacterial-lavanda-3l/p')),
        Store(name: 'Jumbo', url: 'https://www.tiendasjumbo.co/limpia-pisos-fabuloso-antibacterial-lavanda-3l/p', price: await _scrapePrice('https://www.tiendasjumbo.co/limpia-pisos-fabuloso-antibacterial-lavanda-3l/p')),
        Store(name: 'Éxito', url: 'https://www.exito.com/limpiapisos-lavanda-x-3000-ml-311309/p', price: await _scrapePrice('https://www.exito.com/limpiapisos-lavanda-x-3000-ml-311309/p')),
      ],
    );
    aseo.products.add(limpiaPisos);

    // Detergente en polvo
    final detergente = Product(
      name: 'Detergente en polvo',
      category: 'Aseo',
      stores: [
        Store(name: 'Metro', url: 'https://www.tiendasmetro.co/huevos-kikes-rojo-tipo-aa-x30und/p', price: await _scrapePrice('https://www.tiendasmetro.co/huevos-kikes-rojo-tipo-aa-x30und/p')) ,
        Store(name: 'Jumbo', url: 'https://www.tiendasjumbo.co/detergente-fab-ultra-flash-polvo-x-4kg/p', price: await _scrapePrice('https://www.tiendasjumbo.co/detergente-fab-ultra-flash-polvo-x-4kg/p')),
        Store(name: 'Éxito', url: 'https://www.exito.com/detergente-pvo-ultra-fab-4000-gr-3134947/p', price: await _scrapePrice('https://www.exito.com/detergente-pvo-ultra-fab-4000-gr-3134947/p')),
      ],
    );
    aseo.products.add(detergente);

    categories.add(aseo);

    return categories;
  }

Future<double?> _scrapePrice(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final html = response.body; 
    final document = parse(html); 
    final priceElement = document.querySelector('span.price'); 
    final priceText = priceElement?.text;
    if (priceText != null) {
      final price = double.tryParse(priceText.replaceAll(RegExp(r'[^\d\.]'), ''));
      return price;
    } else {
      return null;
    }
  } else {
    return null;
  }
}
}