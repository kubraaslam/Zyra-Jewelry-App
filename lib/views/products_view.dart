import 'package:flutter/material.dart';
import 'package:jewelry_store/controllers/cart_controller.dart';
import 'package:jewelry_store/controllers/product_controller.dart';
import 'package:jewelry_store/models/cart_item_model.dart';
import 'package:jewelry_store/models/product_model.dart';
import 'package:jewelry_store/views/product_details_view.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatelessWidget {
  final bool homePreview;

  const ProductsView({this.homePreview = false, super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);

    if (productController.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    List<ProductModel> displayProducts = productController.products;
    if (homePreview && displayProducts.length > 5) {
      displayProducts = displayProducts.sublist(0, 5);
    }

    // Group products by category
    final Map<String, List<ProductModel>> categorizedProducts = {};
    for (var product in displayProducts) {
      if (!categorizedProducts.containsKey(product.category)) {
        categorizedProducts[product.category] = [];
      }
      categorizedProducts[product.category]!.add(product);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children:
            categorizedProducts.entries.map((entry) {
              final category = entry.key;
              final products = entry.value;

              return Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    "${category[0].toUpperCase()}${category.substring(1)} Collection",
                    style: const TextStyle(fontSize: 22, fontFamily: 'DMSerif'),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 300, // adjust height for the product cards
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Container(
                          width: 200, // card width
                          margin: const EdgeInsets.only(right: 12),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          ProductDetailsView(product: product),
                                ),
                              );
                            },
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      product.imageUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (
                                        context,
                                        child,
                                        loadingProgress,
                                      ) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      errorBuilder:
                                          (_, __, ___) =>
                                              const Icon(Icons.error),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "LKR ${product.price.toStringAsFixed(2)}",
                                        ),
                                        const SizedBox(height: 4),
                                        ElevatedButton(
                                          onPressed: () {
                                            final cartController =
                                                Provider.of<CartController>(
                                                  context,
                                                  listen: false,
                                                );
                                            cartController.addToCart(
                                              CartItemModel(
                                                productId: product.id,
                                                name: product.name,
                                                price: product.price,
                                                imageUrl: product.imageUrl,
                                              ),
                                            );
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  '${product.name} added to cart',
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text('Add to Cart'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}