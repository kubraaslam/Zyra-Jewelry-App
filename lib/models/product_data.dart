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
}

final List<Product> allProducts = [
  Product(
    title: 'Tied Knot Bracelet',
    type: 'Bracelet',
    price: 2500,
    image: 'assets/images/products/tied_knot_bracelet.jpeg',
    description:
        'Elegant in its simplicity, the Tied Knot Bracelet is a timeless accessory that symbolizes strength, unity, and connection. Crafted with precision and care, this bracelet features a delicate knot design that adds a subtle yet meaningful touch to your look. Whether worn alone or layered with other pieces, it effortlessly complements both casual and formal styles.',
  ),
  Product(
    title: 'Teardrop Ear Cuff',
    type: 'Earring',
    price: 1500,
    image: 'assets/images/products/c-shaped_teardrop_earcuff.jpeg',
    description:
        "Make a subtle yet striking statement with the Teardrop Ear Cuff. Designed for modern elegance, this piece features a delicate teardrop silhouette that hugs the ear comfortably—no piercing required. Its sleek design adds a hint of edge and sophistication to any outfit, whether you're dressing up for a night out or adding flair to your everyday look.",
  ),
  Product(
    title: 'Wide Cuff Chunky Bangles',
    type: 'Bracelet',
    price: 2750,
    image: 'assets/images/products/wide_cuff_chunky_bangles.jpeg',
    description:
        'Bold, stylish, and unapologetically statement-making—the Wide Cuff Chunky Bangles are designed to turn heads. With their wide, sculpted silhouette and polished finish, these bangles add instant glamour to any outfit. Whether paired with ethnic wear or modern ensembles, they bring a touch of confidence and edge to your look.',
  ),
  Product(
    title: 'Flower Carved Ring',
    type: 'Ring',
    price: 1000,
    image: 'assets/images/products/flower_ring.png',
    description:
        "Delicate and graceful, the Flower Carved Ring brings nature-inspired elegance to your fingertips. Featuring an intricate floral design etched into its band, this ring captures the beauty of blooms in a timeless form. Lightweight and charming, it's perfect for everyday wear or as a subtle accent for special occasions.",
  ),
  Product(
    title: 'Flower Jeweled Necklace',
    type: 'Necklace',
    price: 3850,
    image: 'assets/images/products/flower_necklace.jpeg',
    description:
        "Radiant and romantic, the Flower Jeweled Necklace is a celebration of beauty and elegance. Adorned with sparkling floral motifs, this necklace blends delicate craftsmanship with a luxurious touch. Whether you're dressing up for a special occasion or adding charm to your everyday outfit, it's a standout piece that captures attention effortlessly.",
  ),
  Product(
    title: 'Butterfly Pearl Earring',
    type: 'Earring',
    price: 2850,
    image: 'assets/images/products/butterfly-pearl-earring.jpeg',
    description: '',
  ),
  Product(
    title: 'Handcrafted Bracelet',
    type: 'Bracelet',
    price: 3250,
    image: 'assets/images/products/handcrafted-bracelet.jpeg',
    description:
        'Timeless craftsmanship meets modern elegance in the Handcrafted Bracelet. Carefully made with attention to detail, each piece carries a unique charm that reflects the beauty of artisanal work. Its refined design makes it perfect for both everyday wear and special occasions, adding a personal, meaningful touch to your jewelry collection.',
  ),
  Product(
    title: 'Sharp Sword Earring',
    type: 'Earring',
    price: 1250,
    image: 'assets/images/products/sharp-sword-earring.jpeg',
    description:
        'Edgy and empowering, the Sharp Sword Earring is a bold piece that channels strength and style. Featuring a sleek, sword-inspired design, it adds a fierce accent to your look—perfect for those who love to stand out with confidence. Lightweight yet impactful, this earring is your go-to for adding attitude to any outfit.',
  ),
  Product(
    title: 'Twisted Ring',
    type: 'Ring',
    price: 850,
    image: 'assets/images/products/twisted-ring.jpeg',
    description:
        'Simple yet striking, the Twisted Ring features an elegant spiral design that wraps gracefully around your finger. Its minimal form and smooth curves make it a versatile accessory—perfect for stacking or wearing solo. Lightweight and comfortable, it adds a touch of effortless charm to your everyday style.',
  ),
  Product(
    title: 'Hollow Heart Hoop Earring',
    type: 'Earring',
    price: 1870,
    image: 'assets/images/products/hollow-heart-hoop-earrings.jpeg',
    description:
        "Playful with a touch of romance, the Hollow Heart Hoop Earring brings a sweet twist to the classic hoop. Shaped in an open-heart silhouette, this piece blends charm and style effortlessly—perfect for adding a flirty flair to both casual and dressy looks. Lightweight and eye-catching, it's love at first wear.",
  ),
  Product(
    title: 'Spiral Swirl Necklace',
    type: 'Necklace',
    price: 2070,
    image: 'assets/images/products/spiral-swirl-necklace.jpeg',
    description:
        'Artistic and elegant, the Spiral Swirl Necklace features a graceful, flowing design that captures movement and creativity. Its sleek curves create a modern yet timeless look, making it a versatile accessory for any occasion. Whether layered or worn solo, this piece adds a refined statement to your neckline.',
  ),
  Product(
    title: 'Wave Ring',
    type: 'Ring',
    price: 1050,
    image: 'assets/images/products/wave-ring.jpeg',
    description:
        'Inspired by the rhythm of the ocean, the Wave Ring features a smooth, flowing design that wraps around your finger with effortless grace. Its minimal yet dynamic form makes it a standout piece for everyday wear, symbolizing fluidity, strength, and calm.',
  ),
  Product(
    title: 'Knot Bracelet',
    type: 'Bracelet',
    price: 3870,
    image: 'assets/images/products/pearl-flower-bracelet.png',
    description:
        'Symbolizing unity and strength, the Knot Bracelet is a beautifully crafted piece that combines simplicity with meaning. Its intertwined design represents lasting bonds and connection, making it a thoughtful accessory for yourself or a loved one. Perfectly balanced between elegance and everyday wearability, this bracelet adds a subtle statement to any outfit.',
  ),
  Product(
    title: 'Sun Pendant Necklace',
    type: 'Necklace',
    price: 1070,
    image: 'assets/images/products/sun-necklace.jpeg',
    description:
        "Brighten your look with the Sun Pendant Necklace, featuring a radiant sun motif that symbolizes warmth, energy, and positivity. This delicate necklace adds a cheerful glow to any outfit, making it perfect for everyday wear or layering with other pieces. Lightweight and versatile, it's a sunny reminder to shine wherever you go.",
  ),
];