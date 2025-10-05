class Product {
  final String title;
  final String type;
  final double price;
  final String image;
  final String description;
  int quantity;

  Product({
    required this.title,
    required this.type,
    required this.price,
    required this.image,
    required this.description,
    this.quantity = 1,
  });

  // Factory constructor inside the class
  factory Product.fromJson(Map<String, dynamic> json) {
    final imagePath = json['image_url'] ?? '';
    final fullImageUrl =
        imagePath.startsWith('http')
            ? imagePath
            : 'http://10.0.2.2:8000/storage/$imagePath'; // for Android emulator

    return Product(
      title: json['name'] ?? '',
      type: json['category'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0,
      image: fullImageUrl,
      description: json['description'] ?? '',
    );
  }
} 