import 'package:flutter/material.dart';
import 'package:jewelry_store/models/category.dart';
import 'package:jewelry_store/models/product.dart';

class Home extends StatelessWidget {
  final List<Category> categories = [
    Category(title: 'RINGS', image: 'assets/rings.jpg'),
    Category(title: 'EARRINGS', image: 'assets/earrings.jpg'),
    Category(title: 'NECKLACE', image: 'assets/necklace.jpg'),
    Category(title: 'BRACELETS', image: 'assets/bracelets.jpg'),
  ];

  final List<Product> trendyItems = [
    Product(title: 'Tied Knot Bracelet', type: 'Bracelet', image: 'assets/tied_knot.jpg'),
    Product(title: 'C-Shape Teardrop Ear Cuff', type: 'Earring', image: 'assets/teardrop_cuff.jpg'),
    Product(title: 'Wide Cuff Chunky Bangles', type: 'Bracelet', image: 'assets/wide_cuff.jpg'),
  ];

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.black),
        title: Column(
          children: [
            Image.asset('assets/images/logo.png', height: 40),
            const Text('JEWELLERY', style: TextStyle(fontSize: 12, color: Colors.black)),
          ],
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.person_outline, color: Colors.black),
          SizedBox(width: 10),
          Icon(Icons.shopping_bag_outlined, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/header_banner.jpg'),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text('Popular Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),

            Column(
              children: categories.map((cat) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(cat.image, height: 100, width: double.infinity, fit: BoxFit.cover),
                      Container(
                        color: Colors.black.withOpacity(0.4),
                        height: 100,
                        alignment: Alignment.center,
                        child: Text(
                          cat.title,
                          style: TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 1.5),
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
                  Text('Trendy Collection', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Elevate your style with our curated modern pieces',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: trendyItems.map((item) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(item.image, height: 100, width: 100, fit: BoxFit.cover),
                      ),
                      SizedBox(height: 5),
                      Text(item.type, style: TextStyle(fontSize: 12, color: Colors.grey)),
                      SizedBox(
                        width: 100,
                        child: Text(item.title, textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}