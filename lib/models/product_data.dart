class Product {
  final String title;
  final String type;
  final double price;
  final String image;
  int quantity;

  Product({
    required this.title,
    required this.type,
    required this.price,
    required this.image,
    this.quantity = 1
  });
}
