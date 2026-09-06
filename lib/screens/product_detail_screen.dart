import 'package:flutter/material.dart';
import '../models/jewelry_model.dart';
import '../data/jewelry_data.dart';

class ProductDetailScreen extends StatefulWidget {
  final JewelryModel jewelry;

  const ProductDetailScreen({
    super.key,
    required this.jewelry,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.jewelry;
    final total = product.price * quantity;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: const Color(0xFFF8F5EF),
            foregroundColor: const Color(0xFF29251F),
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    JewelryStore.toggleWishlist(product);
                  });
                },
                icon: Icon(
                  JewelryStore.isWishlisted(product.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: JewelryStore.isWishlisted(product.id)
                      ? Colors.redAccent
                      : const Color(0xFF29251F),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'jewelry_${product.id}',
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFE9E1D3),
                      child: const Icon(
                        Icons.diamond_outlined,
                        size: 80,
                        color: Color(0xFFB58A45),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 25, 22, 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFFB58A45),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.8,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Color(0xFF29251F),
                      fontSize: 29,
                      fontWeight: FontWeight.w700,
                      height: 1.15,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFD09A3A),
                        size: 21,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '(${product.reviews} reviews)',
                        style: const TextStyle(
                          color: Color(0xFF81796E),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Text(
                    '\$${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Color(0xFF29251F),
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Divider(
                    color: Color(0xFFE2DBD0),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'About this piece',
                    style: TextStyle(
                      color: Color(0xFF29251F),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    product.description,
                    style: const TextStyle(
                      color: Color(0xFF756E65),
                      fontSize: 14,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 25),

                  _InfoRow(
                    icon: Icons.auto_awesome_outlined,
                    title: 'Material',
                    value: product.material,
                  ),

                  const SizedBox(height: 14),

                  const _InfoRow(
                    icon: Icons.verified_outlined,
                    title: 'Quality',
                    value: 'Premium handcrafted finish',
                  ),

                  const SizedBox(height: 28),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF29251F),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFE0D8CC),
                          ),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: quantity > 1
                                  ? () {
                                setState(() {
                                  quantity--;
                                });
                              }
                                  : null,
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {
                        for (int i = 0; i < quantity; i++) {
                          JewelryStore.addToCart(product);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.name} added to your bag',
                            ),
                            backgroundColor: const Color(0xFF29251F),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF29251F),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Add to Bag  •  \$${total.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          JewelryStore.toggleWishlist(product);
                        });
                      },
                      icon: Icon(
                        JewelryStore.isWishlisted(product.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      label: Text(
                        JewelryStore.isWishlisted(product.id)
                            ? 'Remove from Wishlist'
                            : 'Add to Wishlist',
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF29251F),
                        side: const BorderSide(
                          color: Color(0xFFD8CCBC),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFEDE5D8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFB58A45),
            size: 21,
          ),
        ),
        const SizedBox(width: 13),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF8B8378),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF29251F),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}