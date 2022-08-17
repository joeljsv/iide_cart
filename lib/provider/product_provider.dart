// product provider
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse("https://dummyjson.com/products");
    try {
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData.isEmpty) {
        return;
      }
      final prodData = extractedData['products'] as List<dynamic>;
      final List<Product> loadedProducts = [];
      for (var prod in prodData) {
        loadedProducts.add(Product(
          id: prod['id'],
          title: prod['title'],
          description: prod['description'],
          price: double.parse(prod['price'].toString()),
          discountPercentage:
              double.parse(prod['discountPercentage'].toString()),
          rating: double.parse(prod['rating'].toString()),
          stock: int.parse(prod['stock'].toString()),
          brand: prod['brand'],
          category: prod['category'],
          thumbnail: prod['thumbnail'],
          images: prod['images'].cast<String>(),
        ));
      }

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
