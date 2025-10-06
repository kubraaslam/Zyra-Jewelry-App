import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jewelry_store/models/product_model.dart';
import 'package:jewelry_store/services/api_service.dart';
import 'package:jewelry_store/services/storage_service.dart';

class ProductController with ChangeNotifier {
  List<ProductModel> _products = [];
  bool _loading = false;

  List<ProductModel> get products => _products;
  bool get loading => _loading;

  Future<void> fetchProducts() async {
    _loading = true;
    notifyListeners();

    try {
      final data = await ApiService.getProducts();
      _products = data.map((e) => ProductModel.fromJson(e)).toList();

      // Save offline JSON
      await StorageService.writeJson(
          'products.json', _products.map((p) => p.toJson()).toList());

      // Cache images locally
      for (var product in _products) {
        await cacheProductImage(product);
      }
    } catch (_) {
      // If API fails, load offline JSON
      final cached = await StorageService.readJson('products.json');
      _products = cached.map((e) => ProductModel.fromJson(e)).toList();
    }

    _loading = false;
    notifyListeners();
  }

  // This function caches a product image locally
  Future<void> cacheProductImage(ProductModel product) async {
    try {
      final uri = Uri.parse(product.imageUrl);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final file = await StorageService.localFile('product_${product.id}.png');
        await file.writeAsBytes(response.bodyBytes);
      }
    } catch (_) {
      // ignore errors
    }
  }
}
