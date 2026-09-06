import 'package:flutter/material.dart';

import '../data/jewelry_data.dart';
import '../models/jewelry_model.dart';

class JewelryCard extends StatefulWidget {
  final JewelryModel product;
  final VoidCallback onTap;

  const JewelryCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  State<JewelryCard> createState() => _JewelryCardState();
}

class _JewelryCardState extends State<JewelryCard> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final liked = JewelryStore.isWishlisted(product.id);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFFE9E2D8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: product.id,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                    child: AspectRatio(
                      aspectRatio: 0.9,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            color: const Color(0xFFEFE9E0),
                            child: const Icon(
                              Icons.diamond_outlined,
                              size: 55,
                              color: Color(0xFFB08D57),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                if (product.isNew)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF26231F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'NEW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Material(
                    color: Colors.white.withOpacity(.92),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        setState(() {
                          JewelryStore.toggleWishlist(product);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(9),
                        child: Icon(
                          liked
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 18,
                          color: liked
                              ? const Color(0xFF9E5B58)
                              : const Color(0xFF39342F),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 13, 14, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 9,
                      letterSpacing: 1.4,
                      color: Color(0xFF9A8E80),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF292621),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 15,
                        color: Color(0xFFC19657),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${product.rating} (${product.reviews})',
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 10,
                          color: Color(0xFF81776D),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF292621),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}