import 'package:flutter/material.dart';
import 'package:jewelry_store/models/bottom_navbar.dart';
import 'package:jewelry_store/models/product_data.dart';
import 'package:jewelry_store/screens/cart.dart';
import 'package:jewelry_store/screens/home.dart';
import 'package:jewelry_store/screens/product_detail.dart';
import 'package:jewelry_store/screens/wishlist.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Product> cartItems = [];

  List<Product> wishlistItems = [];

  final Map<String, GlobalKey> _sectionKeys = {};

  void addToCart(Product product) {
    setState(() {
      final index = cartItems.indexWhere((item) => item.title == product.title);

      if (index != -1) {
        cartItems[index].quantity++;
      } else {
        cartItems.add(
          Product(
            title: product.title,
            type: product.type,
            price: product.price,
            image: product.image,
            description: product.description,
            quantity: 1,
          ),
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${product.title} added to cart!',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Product>> groupedProducts = {};
    for (var product in allProducts) {
      groupedProducts.putIfAbsent(product.type, () => []).add(product);
    }

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
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
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
                    builder: (context) => Cart(cartItems: cartItems),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            Wishlist(wishlist: wishlistItems, cart: cartItems),
                  ),
                );
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                children: [
                  ...groupedProducts.entries.map((entry) {
                    String type = entry.key;
                    List<Product> products = entry.value;
                    final key = GlobalKey();
                    _sectionKeys[type] = key;

                    return Column(
                      key: key,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Center(
                          child: Text(
                            '${type}s',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              fontFamily: 'Roboto',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 350,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.6,
                              ),
                          itemBuilder: (context, index) {
                            final item = products[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ProductDetail(
                                          item: item,
                                          cart: cartItems,
                                          wishlist: wishlistItems,
                                        ),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          item.image,
                                          width: double.infinity,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        item.title,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'LKR ${item.price.toStringAsFixed(2)}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          fontFamily: 'Roboto',
                                          color:
                                              Theme.of(context).iconTheme.color,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      SizedBox(
                                        width: 100,
                                        height: 36,
                                        child: ElevatedButton(
                                          onPressed: () => addToCart(item),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            padding: EdgeInsets.zero,
                                          ),
                                          child: Text(
                                            'Add to Cart',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium?.copyWith(
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              color:
                                                  Theme.of(
                                                            context,
                                                          ).brightness ==
                                                          Brightness.light
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: 30),
                  Divider(
                    color: Theme.of(context).dividerColor,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '© 2025 All Rights Reserved',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontFamily: 'Roboto',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        cart: cartItems,
        wishlist: wishlistItems,
      ),
    );
  }
}
