class ProductModel {
  final String id;
  final String name;
  final double price;
  final String category;
  final String imageUrl;
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    const String baseImageUrl = 'http://10.0.2.2:8000/storage/';

    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      category: json['category'] ?? '',
      imageUrl: baseImageUrl + (json['image_url'] ?? ''),
      description: (json['description'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'image_url': imageUrl,
      'description': description,
    };
  }
}