import 'package:flutter/material.dart';
import 'package:jewelry_store/models/product_data.dart';

class ProductDetail extends StatefulWidget {
  final Product item;
  final List<Product> cart;     // Shared cart list
  final List<Product> wishlist; // Shared wishlist list

  const ProductDetail({
    super.key,
    required this.item,
    required this.cart,
    required this.wishlist,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 1;
  bool isWishlisted = false;

  @override
  void initState() {
    super.initState();
    // Check if this product is already in the wishlist
    isWishlisted = widget.wishlist.any((p) => p.title == widget.item.title);
  }

  void addToCart(Product product) {
    final index = widget.cart.indexWhere((item) => item.title == product.title);

    if (index != -1) {
      // If product is already in the cart, increase quantity
      widget.cart[index].quantity += quantity;
    } else {
      // Else add as new product
      widget.cart.add(
        Product(
          title: product.title,
          type: product.type,
          price: product.price,
          image: product.image,
          description: product.description,
          quantity: quantity,
        ),
      );
    }

    // Show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${product.title} added to cart!',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void toggleWishlist(Product product) {
    setState(() {
      if (isWishlisted) {
        widget.wishlist.removeWhere((p) => p.title == product.title);
        isWishlisted = false;
      } else {
        widget.wishlist.add(product);
        isWishlisted = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isWishlisted
              ? '${product.title} added to wishlist!'
              : '${product.title} removed from wishlist!',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          item.title,
          style: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: isWishlisted ? Colors.red : Colors.black,
            ),
            onPressed: () => toggleWishlist(item),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(item.image, height: 300, fit: BoxFit.contain),
            SizedBox(height: 20),
            Text(
              item.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              item.type,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
                fontSize: 14,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'LKR ${item.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                item.description,
                style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline, size: 30),
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                ),
                Text(
                  quantity.toString(),
                  style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, size: 30),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () => addToCart(item),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                ),
                child: Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}