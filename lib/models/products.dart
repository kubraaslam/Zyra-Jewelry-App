import 'package:flutter/material.dart';
import 'package:jewelry_store/models/product_data.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final List<Product> cart = [];

  final List<Product> trendyItems = [
    Product(
      title: 'Tied Knot Bracelet',
      type: 'Bracelet',
      price: 2500,
      image: 'assets/images/products/tied_knot_bracelet.jpeg',
    ),
    Product(
      title: 'Teardrop Ear Cuff',
      type: 'Earring',
      price: 1500,
      image: 'assets/images/products/c-shaped_teardrop_earcuff.jpeg',
    ),
    Product(
      title: 'Wide Cuff Chunky Bangles',
      type: 'Bracelet',
      price: 2750,
      image: 'assets/images/products/wide_cuff_chunky_bangles.jpeg',
    ),
    Product(
      title: 'Flower Carved Ring',
      type: 'Ring',
      price: 1000,
      image: 'assets/images/products/flower_ring.png',
    ),
    Product(
      title: 'Flower Jeweled Necklace',
      type: 'Necklace',
      price: 3850,
      image: 'assets/images/products/flower_necklace.jpeg',
    ),
  ];

  void addToCart(Product product) {
    setState(() {
      // Check if the product is already in the cart
      final index = cart.indexWhere((item) => item.title == product.title);

      if (index != -1) {
        // Already in cart → increase quantity
        cart[index].quantity++;
      } else {
        // Not in cart → add with quantity 1
        cart.add(
          Product(
            title: product.title,
            type: product.type,
            price: product.price,
            image: product.image,
            quantity: 1,
          ),
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${product.title} added to cart!',
          style: TextStyle(fontFamily: 'PlayfairDisplay'),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 68, 67),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold();
  }}