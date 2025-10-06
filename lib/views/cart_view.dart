import 'package:flutter/material.dart';
import 'package:jewelry_store/controllers/cart_controller.dart';
import 'package:jewelry_store/views/checkout_view.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);

    if (cartController.items.isEmpty) {
      return const Center(child: Text('Your cart is empty'));
    }

    double totalPrice = cartController.items.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: cartController.items.length,
            itemBuilder: (context, index) {
              final item = cartController.items[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: Image.network(
                    item.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    item.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("LKR ${item.price} x ${item.quantity}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cartController.updateQuantity(
                            item.productId,
                            item.quantity - 1,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cartController.updateQuantity(
                            item.productId,
                            item.quantity + 1,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[700],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Total: LKR ${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (cartController.items.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Cart is empty")),
                    );
                    return;
                  }

                  // Navigate to the checkout page and pass cart items
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => CheckoutView(
                            cartItems: cartController.items,
                            totalPrice: cartController.totalPrice,
                          ),
                    ),
                  );
                },
                child: const Text("Checkout", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}