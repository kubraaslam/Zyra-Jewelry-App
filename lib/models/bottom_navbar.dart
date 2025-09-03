import 'package:flutter/material.dart';
import 'package:jewelry_store/models/product_data.dart';
import 'package:jewelry_store/screens/cart.dart';
import 'package:jewelry_store/screens/home.dart';
import 'package:jewelry_store/screens/products.dart';
import 'package:jewelry_store/screens/wishlist.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<Product> wishlist;
  final List<Product> cart;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.wishlist,
    required this.cart,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = Home();
        break;
      case 1:
        nextScreen = Wishlist(wishlist: wishlist, cart: cart);
        break;
      case 2:
        nextScreen = Products();
        break;
      case 3:
        nextScreen = Cart(cartItems: cart);
        break;
      default:
        nextScreen = Home();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex >= 0 && currentIndex <= 3 ? currentIndex : 0,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
        BottomNavigationBarItem(icon: Icon(Icons.collections), label: 'Products'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
      ],
    );
  }
}
