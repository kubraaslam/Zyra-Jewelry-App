import 'package:flutter/material.dart';
import 'package:jewelry_store/models/category.dart';
import 'package:jewelry_store/models/product.dart';

class Home extends StatelessWidget {
  final List<Category> categories = [
    Category(title: 'RINGS', image: 'assets/images/rings.jpg'),
    Category(title: 'EARRINGS', image: 'assets/images/earrings.jpeg'),
    Category(title: 'NECKLACES', image: 'assets/images/necklaces.jpeg'),
    Category(title: 'BRACELETS', image: 'assets/images/bracelets.jpeg'),
  ];

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

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.menu_rounded, color: Colors.black),
        title: Column(
          children: [Image.asset('assets/images/logo.png', height: 50)],
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.shopping_bag_outlined, color: Colors.black),
          SizedBox(width: 10),
          Icon(Icons.account_circle, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/home_header.jpg',
              height: 125,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Popular Categories',
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Column(
              children:
                  categories.map((cat) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            cat.image,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(102, 67, 65, 65),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                cat.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'PlayfairDisplay',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Elevate your style with our curated modern pieces',
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    trendyItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                item.image,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              item.type,
                              style: TextStyle(
                                fontFamily: 'PlayfairDisplay',
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                item.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'LKR ${item.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontFamily: 'PlayfairDisplay',
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 5),
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add to cart logic here
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  backgroundColor: Colors.black,
                                ),
                                child: Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),

            SizedBox(height: 20),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            //footer content
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '© 2025 All Rights Reserved',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/about');
                  },
                  child: Text(
                    'About Us',
                    style: TextStyle(fontFamily: 'PlayfairDisplay'),
                  ),
                ),
                Text('|', style: TextStyle(color: Colors.grey)),
                TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/contact');
                  },
                  child: Text(
                    'Contact',
                    style: TextStyle(fontFamily: 'PlayfairDisplay'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.facebook, color: Colors.grey),
                SizedBox(width: 10),
                Icon(Icons.camera_alt, color: Colors.grey), // for Instagram
              ],
            ),
          ],
        ),
      ),
    );
  }
}
