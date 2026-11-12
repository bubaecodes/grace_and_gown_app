class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
    required this.fabric,
    required this.sizes,
    required this.availability,
  });

  final String id;
  final String name;
  final String category;
  final String price;
  final String image;
  final String description;
  final String fabric;
  final List<String> sizes;
  final String availability;
}