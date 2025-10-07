import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jewelry_store/controllers/cart_controller.dart';
import 'package:jewelry_store/controllers/order_controller.dart';
import 'package:jewelry_store/models/cart_item_model.dart';
import 'package:jewelry_store/models/order_model.dart';
import 'package:jewelry_store/views/home_view.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatefulWidget {
  final List<CartItemModel> cartItems;
  final double totalPrice;

  const CheckoutView({
    required this.cartItems,
    required this.totalPrice,
    super.key,
  });

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _formKey = GlobalKey<FormState>();
  String name = '', email = '', address = '';
  String paymentMethod = 'Cash';
  String cardNumber = '', cardExpiry = '', cardCvv = '';

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context, listen: false);
    final orderController = Provider.of<OrderController>(
      context,
      listen: false,
    );

    final cartItems = widget.cartItems;
    final totalPrice = widget.totalPrice;

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Order Summary",
                style: TextStyle(fontSize: 28, fontFamily: 'DMSerif'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              ...cartItems.map(
                (item) => ListTile(
                  title: Text(item.name),
                  trailing: Text(
                    "${item.quantity} x LKR ${item.price.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const Divider(height: 32),
              Text(
                "Total: LKR ${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 24),

              // Billing info
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (val) => val!.isEmpty ? "Enter name" : null,
                  onSaved: (val) => name = val!,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Address"),
                  validator: (val) => val!.isEmpty ? "Enter address" : null,
                  onSaved: (val) => address = val!,
                ),
              ),

              // Payment method
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  value: paymentMethod,
                  items: const [
                    DropdownMenuItem(value: 'Cash', child: Text('Cash')),
                    DropdownMenuItem(value: 'Card', child: Text('Card')),
                  ],
                  onChanged: (val) => setState(() => paymentMethod = val!),
                  decoration: const InputDecoration(
                    labelText: "Payment Method",
                  ),
                ),
              ),

              if (paymentMethod == 'Card') ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Card Number"),
                    validator:
                        (val) => val!.isEmpty ? "Enter card number" : null,
                    onSaved: (val) => cardNumber = val!,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Expiry MM/YY",
                    ),
                    validator: (val) => val!.isEmpty ? "Enter expiry" : null,
                    onSaved: (val) => cardExpiry = val!,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "CVV"),
                    validator: (val) => val!.isEmpty ? "Enter CVV" : null,
                    onSaved: (val) => cardCvv = val!,
                  ),
                ),
              ],

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final orderDate = DateFormat(
                        'yyyy-MM-dd',
                      ).format(DateTime.now());
                      final deliveryDate = DateFormat(
                        'yyyy-MM-dd',
                      ).format(DateTime.now().add(const Duration(days: 14)));

                      final order = OrderModel(
                        total: totalPrice,
                        customerName: name,
                        email: email,
                        address: address,
                        paymentMethod: paymentMethod,
                        cardNumber: cardNumber,
                        cardExpiry: cardExpiry,
                        cardCvv: cardCvv,
                        orderDate: orderDate,
                        deliveryDate: deliveryDate,
                      );

                      // Save order in database
                      await orderController.createOrder(order, cartItems);

                      // Clear cart
                      await cartController.clearCart();

                      // Show delivery popup and navigate home
                      showDialog(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: const Text("Order Placed!"),
                              content: Text(
                                "Your delivery date is $deliveryDate",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const HomeView(),
                                      ),
                                      (route) =>
                                          false, // Removes all previous routes
                                    );
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                      );
                    }
                  },
                  child: const Text(
                    "Place Order",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
