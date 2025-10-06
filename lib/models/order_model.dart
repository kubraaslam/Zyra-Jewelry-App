class OrderModel {
  final int? id;
  final double total;
  final String customerName;
  final String email;
  final String address;
  final String paymentMethod;
  final String? cardNumber;
  final String? cardExpiry;
  final String? cardCvv;
  final String orderDate;
  final String deliveryDate;

  OrderModel({
    this.id,
    required this.total,
    required this.customerName,
    required this.email,
    required this.address,
    required this.paymentMethod,
    this.cardNumber,
    this.cardExpiry,
    this.cardCvv,
    required this.orderDate,
    required this.deliveryDate,
  });

  Map<String, dynamic> toMap() => {
        'total': total,
        'customer_name': customerName,
        'email': email,
        'address': address,
        'payment_method': paymentMethod,
        'card_number': cardNumber,
        'card_expiry': cardExpiry,
        'card_cvv': cardCvv,
        'order_date': orderDate,
        'delivery_date': deliveryDate,
      };
}