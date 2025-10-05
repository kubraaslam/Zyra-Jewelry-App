// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:jewelry_store/models/bottom_navbar.dart';
import 'package:jewelry_store/models/category.dart';
import 'package:jewelry_store/models/product_data.dart';
import 'package:jewelry_store/screens/login.dart';
import 'package:jewelry_store/screens/products.dart';
import 'package:jewelry_store/screens/cart.dart';
import 'package:jewelry_store/screens/wishlist.dart';
import 'package:jewelry_store/services/api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Product> cartItems = [];
  List<Product> wishlistItems = [];

  final ApiService apiService = ApiService();

  // Screens for IndexedStack
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeContent(
        cartItems: cartItems,
        wishlistItems: wishlistItems,
        apiService: apiService,
      ),
      Wishlist(wishlist: wishlistItems, cart: cartItems),
      Products(cartItems: cartItems, wishlistItems: wishlistItems),
      Cart(cartItems: cartItems),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

// Separated Home content into its own StatefulWidget
class HomeContent extends StatefulWidget {
  final List<Product> cartItems;
  final List<Product> wishlistItems;
  final ApiService apiService;

  const HomeContent({
    super.key,
    required this.cartItems,
    required this.wishlistItems,
    required this.apiService,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Category> categories = [
    Category(title: 'RINGS', image: 'assets/images/rings.jpg'),
    Category(title: 'EARRINGS', image: 'assets/images/earrings.jpeg'),
    Category(title: 'NECKLACES', image: 'assets/images/necklaces.jpeg'),
    Category(title: 'BRACELETS', image: 'assets/images/bracelets.jpeg'),
  ];

  List<Product> trendyItems = [];
  bool _isLoadingTrendy = true;

  @override
  void initState() {
    super.initState();
    fetchTrendyProducts();
  }

  Future<void> fetchTrendyProducts() async {
    setState(() => _isLoadingTrendy = true);
    try {
      trendyItems = await widget.apiService.getProducts();
      print("Fetched trendy items: ${trendyItems.length}");
    } catch (e) {
      print("Error fetching trendy products: $e");
    } finally {
      setState(() => _isLoadingTrendy = false);
    }
  }

  void addToCart(Product product) {
    setState(() {
      final index =
          widget.cartItems.indexWhere((item) => item.title == product.title);
      if (index != -1) {
        widget.cartItems[index].quantity++;
      } else {
        widget.cartItems.add(
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
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
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
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
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
              title: Text('Home',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      )),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.collections),
              title: Text('Products',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      )),
              onTap: () {
                Navigator.pop(context);
                // Optional: you can switch to Products tab instead
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Cart',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      )),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Wishlist',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      )),
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
          icon: Icon(Icons.menu_rounded, color: Theme.of(context).iconTheme.color),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/home_header.png',
              height: 125,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Popular Categories',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: categories.map((cat) {
                return GestureDetector(
                  onTap: () {
                    // Could switch to Products tab
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(cat.image, height: 150, width: double.infinity, fit: BoxFit.cover),
                        Container(
                          height: 150,
                          width: double.infinity,
                          color: Color.fromRGBO(128, 128, 128, 0.3),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cat.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Trendy Collection',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Elevate your style with our curated modern pieces',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _isLoadingTrendy
                  ? SizedBox(height: 200, child: Center(child: CircularProgressIndicator()))
                  : Row(
                      children: trendyItems.map((item) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to ProductDetail if needed
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(item.image, height: 150, width: 150, fit: BoxFit.cover),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  item.type[0].toUpperCase() + item.type.substring(1),
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontFamily: 'Roboto',
                                        fontStyle: FontStyle.italic,
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                ),
                                SizedBox(
                                  width: 125,
                                  child: Text(item.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontFamily: 'Roboto', fontSize: 16)),
                                ),
                                Text('LKR ${item.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontFamily: 'Roboto', fontWeight: FontWeight.w900, fontSize: 16)),
                                SizedBox(height: 5),
                                SizedBox(
                                  width: 120,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      addToCart(item);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                                    ),
                                    child: Text('Add to Cart', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontFamily: 'Roboto', fontSize: 14, color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}