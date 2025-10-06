import 'package:flutter/material.dart';
import 'package:jewelry_store/controllers/auth_controller.dart';
import 'package:jewelry_store/controllers/cart_controller.dart';
import 'package:jewelry_store/controllers/product_controller.dart';
import 'package:jewelry_store/models/cart_item_model.dart';
import 'package:jewelry_store/models/category_model.dart';
import 'package:jewelry_store/models/product_model.dart';
import 'package:jewelry_store/views/cart_view.dart';
import 'package:jewelry_store/views/login_view.dart';
import 'package:jewelry_store/views/products_view.dart';
import 'package:jewelry_store/views/profile_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Category> categories = [
    Category(title: 'BRACELETS', image: 'assets/images/bracelets.jpeg'),
    Category(title: 'EARRINGS', image: 'assets/images/earrings.jpeg'),
    Category(title: 'NECKLACES', image: 'assets/images/necklaces.jpeg'),
    Category(title: 'RINGS', image: 'assets/images/rings.jpg'),
  ];

  @override
  void initState() {
    super.initState();

    // Fetch products after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productController = Provider.of<ProductController>(
        context,
        listen: false,
      );
      productController.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final productController = Provider.of<ProductController>(context);

    // Home page content (trendy collection)
    Widget homeContent() {
      List<ProductModel> trendyProducts = productController.products;
      if (trendyProducts.length > 5) {
        trendyProducts = trendyProducts.sublist(0, 5);
      }

      return productController.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/home_header.png',
                  height: 125,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                // Popular Categories Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Popular Categories',
                        style: TextStyle(fontSize: 22, fontFamily: 'DMSerif'),
                      ),
                      const SizedBox(height: 12),
                      // List of categories stacked vertically
                      Column(
                        children:
                            categories.map((cat) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigate to products
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProductsView(),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  height: 150,
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      // Category Image
                                      ClipRRect(
                                        child: Image.asset(
                                          cat.image,
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // Semi-transparent overlay
                                      Container(
                                        height: 150,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                            0,
                                            0,
                                            0,
                                            0.3,
                                          ),
                                        ),
                                      ),
                                      // Category Title
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            cat.title,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium?.copyWith(
                                              fontFamily: 'DMSerif',
                                              fontSize: 18,
                                              letterSpacing: 5.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),

                // Trendy Collection Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Trendy Collection',
                        style: TextStyle(fontSize: 22, fontFamily: 'DMSerif'),
                      ),
                      Text(
                        'Elevate your style with our curated modern pieces',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height:
                            300, // Set height for horizontal scrolling cards
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: trendyProducts.length,
                          itemBuilder: (context, index) {
                            final product = trendyProducts[index];
                            return Container(
                              width: 200, // Width of each product card
                              margin: const EdgeInsets.only(right: 12),
                              child: Card(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return const Center(
                                            child: Icon(
                                              Icons.broken_image,
                                              size: 40,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Text(
                                              product.category[0]
                                                      .toUpperCase() +
                                                  product.category.substring(1),
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            Text(
                                              product.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "LKR ${product.price.toStringAsFixed(2)}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
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
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
    }

    // Pages for bottom navigation
    final List<Widget> pages = [
      homeContent(),
      const ProductsView(), // full products page
      const CartView(), // cart page
      const ProfileView(), // profile page
    ];

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 60),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              accountName: Text(authController.user?.username ?? ''),
              accountEmail: Text(authController.user?.email ?? ''),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                authController.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginView()),
                );
              },
            ),
          ],
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}