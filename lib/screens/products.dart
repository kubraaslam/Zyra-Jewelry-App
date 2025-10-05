import 'package:flutter/material.dart';
import 'package:jewelry_store/models/product_data.dart';
import 'package:jewelry_store/screens/product_detail.dart';
import 'package:jewelry_store/services/api_service.dart';

class Products extends StatefulWidget {
  final List<Product> cartItems;
  final List<Product> wishlistItems;

  const Products({
    super.key,
    required this.cartItems,
    required this.wishlistItems,
  });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Product> apiProducts = [];
  bool isLoading = true;

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() => isLoading = true);
    try {
      apiProducts = await apiService.getProducts();
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching products: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void addToCart(Product product) {
    setState(() {
      final index = widget.cartItems.indexWhere(
        (item) => item.title == product.title,
      );
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
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Product>> groupedProducts = {};
    for (var product in apiProducts) {
      groupedProducts.putIfAbsent(product.type, () => []).add(product);
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu_rounded,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Image.asset('assets/images/logo.png', height: 60),
        centerTitle: true,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children:
                      groupedProducts.entries.map((entry) {
                        String type = entry.key;
                        List<Product> products = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            Center(
                              child: Text(
                                '${type[0].toUpperCase()}${type.substring(1)} Collection',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  fontFamily: 'Roboto',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: products.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 350,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                              itemBuilder: (context, index) {
                                final item = products[index];
                                return GestureDetector(
                                  onTap:
                                      () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => ProductDetail(
                                                item: item,
                                                cart: widget.cartItems,
                                                wishlist: widget.wishlistItems,
                                              ),
                                        ),
                                      ),
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
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.network(
                                              item.image,
                                              width: double.infinity,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
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
                                          const SizedBox(height: 4),
                                          Text(
                                            'LKR ${item.price.toStringAsFixed(2)}',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium?.copyWith(
                                              fontFamily: 'Roboto',
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).iconTheme.color,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            width: 100,
                                            height: 36,
                                            child: ElevatedButton(
                                              onPressed: () => addToCart(item),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Theme.of(
                                                              context,
                                                            ).brightness ==
                                                            Brightness.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                padding: EdgeInsets.zero,
                                              ),
                                              child: Text(
                                                'Add to Cart',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14,
                                                      color:
                                                          Theme.of(
                                                                    context,
                                                                  ).brightness ==
                                                                  Brightness
                                                                      .light
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
                      }).toList(),
                ),
              ),
    );
  }
}
