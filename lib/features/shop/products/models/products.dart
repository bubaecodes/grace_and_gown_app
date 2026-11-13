class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    this.imageAspect = 0.8,
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

  /// width ÷ height of [image]. The image box uses this so the whole photo
  /// is visible with no crop and no letterboxing. Defaults to 0.8 (4:5).
  final double imageAspect;

  final String description;
  final String fabric;
  final List<String> sizes;
  final String availability;
}
