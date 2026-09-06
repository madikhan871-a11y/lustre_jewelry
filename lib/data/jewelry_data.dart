import '../models/jewelry_model.dart';

final List<JewelryModel> jewelryProducts = [
  JewelryModel(
    id: '1',
    name: 'Celeste Ring',
    category: 'Rings',
    imageUrl:
    'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=900',
    price: 189.00,
    rating: 4.9,
    reviews: '128',
    material: '18K Gold',
    isNew: true,
    description:
    'A delicate statement ring designed with timeless elegance. Crafted in polished 18K gold with a refined stone setting.',
  ),
  JewelryModel(
    id: '2',
    name: 'Aurora Necklace',
    category: 'Necklaces',
    imageUrl:
    'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=900',
    price: 249.00,
    rating: 4.8,
    reviews: '96',
    material: 'Gold Plated',
    isBestSeller: true,
    description:
    'An elegant necklace inspired by soft morning light. Perfect for adding a sophisticated touch to everyday outfits.',
  ),
  JewelryModel(
    id: '3',
    name: 'Luna Earrings',
    category: 'Earrings',
    imageUrl:
    'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=900',
    price: 129.00,
    rating: 4.7,
    reviews: '84',
    material: 'Sterling Silver',
    isBestSeller: true,
    description:
    'Minimal crescent-inspired earrings with a polished finish and lightweight construction for comfortable everyday wear.',
  ),
  JewelryModel(
    id: '4',
    name: 'Seraph Bracelet',
    category: 'Bracelets',
    imageUrl:
    'https://images.unsplash.com/photo-1611652022419-a9419f74343d?w=900',
    price: 179.00,
    rating: 4.9,
    reviews: '72',
    material: '14K Gold',
    isNew: true,
    description:
    'A refined bracelet featuring a graceful chain silhouette and subtle details that make it easy to layer.',
  ),
  JewelryModel(
    id: '5',
    name: 'Elysian Pendant',
    category: 'Necklaces',
    imageUrl:
    'https://images.unsplash.com/photo-1617038220319-276d3cfab638?w=900',
    price: 299.00,
    rating: 4.9,
    reviews: '143',
    material: '18K Gold',
    isBestSeller: true,
    description:
    'A sophisticated pendant designed around a graceful central stone and an elegant gold frame.',
  ),
  JewelryModel(
    id: '6',
    name: 'Amara Ring',
    category: 'Rings',
    imageUrl:
    'https://images.unsplash.com/photo-1627293509201-cd7c7b4b9f7f?w=900',
    price: 219.00,
    rating: 4.8,
    reviews: '65',
    material: 'Rose Gold',
    description:
    'A modern rose-gold ring with a clean silhouette, designed for a subtle yet luxurious appearance.',
  ),
  JewelryModel(
    id: '7',
    name: 'Pearl Drop',
    category: 'Earrings',
    imageUrl:
    'https://images.unsplash.com/photo-1635767798638-3e25273a8236?w=900',
    price: 159.00,
    rating: 4.6,
    reviews: '58',
    material: 'Freshwater Pearl',
    description:
    'Classic pearl earrings with a modern drop silhouette. A beautiful choice for special occasions.',
  ),
  JewelryModel(
    id: '8',
    name: 'Solara Cuff',
    category: 'Bracelets',
    imageUrl:
    'https://images.unsplash.com/photo-1573408301185-9146fe634ad0?w=900',
    price: 269.00,
    rating: 4.8,
    reviews: '91',
    material: '18K Gold',
    isNew: true,
    description:
    'A sculptural cuff bracelet with a polished gold finish and contemporary lines.',
  ),
];

final List<String> jewelryCategories = [
  'All',
  'Rings',
  'Necklaces',
  'Earrings',
  'Bracelets',
];

class JewelryStore {
  static final List<JewelryModel> cart = [];
  static final List<JewelryModel> wishlist = [];

  static void toggleWishlist(JewelryModel product) {
    final index = wishlist.indexWhere((item) => item.id == product.id);

    if (index >= 0) {
      wishlist.removeAt(index);
    } else {
      wishlist.add(product);
    }
  }

  static bool isWishlisted(String id) {
    return wishlist.any((item) => item.id == id);
  }

  static void addToCart(JewelryModel product) {
    cart.add(product);
  }

  static void removeFromCart(String id) {
    cart.removeWhere((item) => item.id == id);
  }

  static double get subtotal {
    return cart.fold(0, (sum, item) => sum + item.price);
  }
}