class JewelryModel {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final double rating;
  final String reviews;
  final String description;
  final String material;
  final bool isNew;
  final bool isBestSeller;

  JewelryModel({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.material,
    this.isNew = false,
    this.isBestSeller = false,
  });
}