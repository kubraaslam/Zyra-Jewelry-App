import 'package:flutter/material.dart';
import 'package:jewelry_store/models/bottom_navbar.dart';
import 'package:jewelry_store/models/product_data.dart';
import 'package:jewelry_store/screens/cart.dart';
import 'package:jewelry_store/screens/product_detail.dart';
import 'package:jewelry_store/screens/products.dart';

class Wishlist extends StatefulWidget {
  final List<Product> wishlist;
  final List<Product> cart;

  const Wishlist({super.key, required this.wishlist, required this.cart});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void removeFromWishlist(Product product) {
    setState(() {
      widget.wishlist.removeWhere((p) => p.title == product.title);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} removed from wishlist'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Text(
                'Zyra Jewelry',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Home',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.collections),
              title: Text(
                'Products',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Products()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text(
                'Cart',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(cartItems: widget.cart),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text(
                'Wishlist',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu_rounded,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Column(
          children: [Image.asset('assets/images/logo.png', height: 60)],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body:
          widget.wishlist.isEmpty
              ? Center(
                child: Text(
                  'No items in your wishlist.',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              : ListView.builder(
                itemCount: widget.wishlist.length,
                itemBuilder: (context, index) {
                  final product = widget.wishlist[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: ListTile(
                      leading: Image.asset(
                        product.image,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        product.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('LKR ${product.price.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => removeFromWishlist(product),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ProductDetail(
                                  item: product,
                                  cart: widget.cart,
                                  wishlist: widget.wishlist,
                                ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        cart: widget.cart,
        wishlist: widget.wishlist,
      ),
    );
  }
}
