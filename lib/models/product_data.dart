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
    this.quantity = 1,
  });
}

final List<Product> allProducts = [
  Product(
    title: 'Tied Knot Bracelet',
    type: 'Bracelet',
    price: 2500,
    image: 'assets/images/products/tied_knot_bracelet.jpeg',
  ),
  Product(
    title: 'Teardrop Ear Cuff',
    type: 'Earring',
    price: 1500,
    image: 'assets/images/products/c-shaped_teardrop_earcuff.jpeg',
  ),
  Product(
    title: 'Wide Cuff Chunky Bangles',
    type: 'Bracelet',
    price: 2750,
    image: 'assets/images/products/wide_cuff_chunky_bangles.jpeg',
  ),
  Product(
    title: 'Flower Carved Ring',
    type: 'Ring',
    price: 1000,
    image: 'assets/images/products/flower_ring.png',
  ),
  Product(
    title: 'Flower Jeweled Necklace',
    type: 'Necklace',
    price: 3850,
    image: 'assets/images/products/flower_necklace.jpeg',
  ),
  Product(
    title: 'Butterfly Pearl Earring',
    type: 'Earring',
    price: 2850,
    image: 'assets/images/products/butterfly-pearl-earring.jpeg',
  ),
  Product(
    title: 'Handcrafted Bracelet',
    type: 'Bracelet',
    price: 3250,
    image: 'assets/images/products/handcrafted-bracelet.jpeg',
  ),
  Product(
    title: 'Sharp Sword Earring',
    type: 'Earring',
    price: 1250,
    image: 'assets/images/products/sharp-sword-earring.jpeg',
  ),
  Product(
    title: 'Twisted Ring',
    type: 'Ring',
    price: 850,
    image: 'assets/images/products/twisted-ring.jpeg',
  ),
  Product(
    title: 'Hollow Heart Hoop Earring',
    type: 'Earring',
    price: 1870,
    image: 'assets/images/products/hollow-heart-hoop-earrings.jpeg',
  ),
  Product(
    title: 'Spiral Swirl Necklace',
    type: 'Necklace',
    price: 2070,
    image: 'assets/images/products/spiral-swirl-necklace.jpeg',
  ),
  Product(
    title: 'Wave Ring',
    type: 'Ring',
    price: 1050,
    image: 'assets/images/products/wave-ring.jpeg',
  ),
  Product(
    title: 'Knot Bracelet',
    type: 'Bracelet',
    price: 3870,
    image: 'assets/images/products/pearl-flower-bracelet.png',
  ),
  Product(
    title: 'Sun Pendant Necklace',
    type: 'Necklace',
    price: 1070,
    image: 'assets/images/products/sun-necklace.jpeg',
  ),
];