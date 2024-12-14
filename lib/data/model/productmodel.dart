class Product {
  final String? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final double? price;
  bool isfavorite;

  Product({
    required this.title,
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.isfavorite = false,
  });
}
