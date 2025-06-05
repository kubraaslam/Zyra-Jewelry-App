import 'package:flutter/material.dart';
import 'package:jewelry_store/models/product_data.dart';

class ProductDetail extends StatefulWidget {
  final Product item;

  const ProductDetail({super.key, required this.item});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final List<Product> cart = [];

  int quantity = 1;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

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
          description: product.description,
          quantity: 1,
        ));
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${product.title} added to cart!',
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 68, 67),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        titleTextStyle: TextStyle(fontFamily: 'Roboto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(item.image, height: 200),
            SizedBox(height: 16),
            Text(
              item.title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(item.type, style: TextStyle(color: Colors.grey, fontFamily: 'Roboto')),
            SizedBox(height: 16),
            Text(
              'Price: LKR ${item.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
            ),
            SizedBox(height: 20),
            Text(
              item.description,
              style: TextStyle(fontSize: 14),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: Colors.white),
                  onPressed: decreaseQuantity,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '$quantity',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: increaseQuantity,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => addToCart(item),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}