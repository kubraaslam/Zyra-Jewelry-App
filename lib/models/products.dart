import 'package:flutter/material.dart';
import 'package:jewelry_store/models/product_data.dart';
import 'package:jewelry_store/screens/cart.dart';
import 'package:jewelry_store/screens/home.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      final index = cart.indexWhere((item) => item.title == product.title);

      if (index != -1) {
        cart[index].quantity++;
      } else {
        cart.add(Product(
          title: product.title,
          type: product.type,
          price: product.price,
          image: product.image,
          quantity: 1,
        ));
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
  Widget build(BuildContext context) {
    Map<String, List<Product>> groupedProducts = {};

    for (var product in trendyItems) {
      groupedProducts.putIfAbsent(product.type, () => []).add(product);
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Text(
                'Zyra Jewelry',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home', style: TextStyle(fontFamily: 'PlayfairDisplay')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Cart', style: TextStyle(fontFamily: 'PlayfairDisplay')),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => Cart(cartItems: cart)));
              },
            ),
            ListTile(
              leading: Icon(Icons.collections),
              title: Text('Products', style: TextStyle(fontFamily: 'PlayfairDisplay')),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu_rounded, color: Colors.black),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Column(
          children: [Image.asset('assets/images/logo.png', height: 50)],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => Cart(cartItems: cart))),
          ),
          SizedBox(width: 10),
          Icon(Icons.account_circle, color: Colors.black),
          SizedBox(width: 10),
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

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          '${type}s',
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (context, index) {
                            final item = products[index];
                            return Card(
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
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      item.title,
                                      style: TextStyle(
                                        fontFamily: 'PlayfairDisplay',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'LKR ${item.price.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontFamily: 'PlayfairDisplay',
                                        color: Colors.grey[800],
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    SizedBox(
                                      width: 100,
                                      height: 32,
                                      child: ElevatedButton(
                                        onPressed: () => addToCart(item),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: Text(
                                          'Add to Cart',
                                          style: TextStyle(
                                            fontFamily: 'PlayfairDisplay',
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                    color: Colors.grey.shade300,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '© 2025 All Rights Reserved',
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text('About Us', style: TextStyle(fontFamily: 'PlayfairDisplay')),
                            ),
                            Text('|', style: TextStyle(color: Colors.grey)),
                            TextButton(
                              onPressed: () {},
                              child: Text('Contact', style: TextStyle(fontFamily: 'PlayfairDisplay')),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.facebook, color: Colors.grey),
                            SizedBox(width: 10),
                            Icon(Icons.camera_alt, color: Colors.grey),
                          ],
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
    );
  }
}