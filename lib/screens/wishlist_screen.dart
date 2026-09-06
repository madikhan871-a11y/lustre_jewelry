import 'package:flutter/material.dart';
import '../data/jewelry_data.dart';
import '../models/jewelry_model.dart';
import 'product_detail_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final wishlist = JewelryStore.wishlist;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5EF),
        foregroundColor: const Color(0xFF29251F),
        elevation: 0,
        titleSpacing: 20,
        title: const Text(
          'My Wishlist',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (wishlist.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Center(
                child: Text(
                  '${wishlist.length} items',
                  style: const TextStyle(
                    color: Color(0xFF8B8378),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: wishlist.isEmpty
          ? _buildEmptyState()
          : GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        itemCount: wishlist.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 18,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, index) {
          final product = wishlist[index];

          return _WishlistCard(
            product: product,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(
                    jewelry: product,
                  ),
                ),
              ).then((_) {
                setState(() {});
              });
            },
            onRemove: () {
              setState(() {
                JewelryStore.toggleWishlist(product);
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 95,
              height: 95,
              decoration: const BoxDecoration(
                color: Color(0xFFEDE5D8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 45,
                color: Color(0xFFB58A45),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Your wishlist is empty',
              style: TextStyle(
                color: Color(0xFF29251F),
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 9),
            const Text(
              'Save your favorite jewelry pieces here\nand find them whenever you want.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF81796E),
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF29251F),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: const Text(
                'Explore Jewelry',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WishlistCard extends StatelessWidget {
  final JewelryModel product;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _WishlistCard({
    required this.product,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: const Color(0xFFE7DED2),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFEDE5D8),
                          child: const Center(
                            child: Icon(
                              Icons.diamond_outlined,
                              size: 50,
                              color: Color(0xFFB58A45),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Positioned(
                    top: 9,
                    right: 9,
                    child: Material(
                      color: Colors.white.withValues(alpha: 0.94),
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: onRemove,
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(9),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (product.isNew)
                    Positioned(
                      left: 10,
                      top: 10,
                      child: _WishlistTag(
                        text: 'NEW',
                      ),
                    )
                  else if (product.isBestSeller)
                    Positioned(
                      left: 10,
                      top: 10,
                      child: _WishlistTag(
                        text: 'BEST SELLER',
                      ),
                    ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 11, 12, 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF29251F),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: Color(0xFFD09A3A),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(
                          color: Color(0xFF746C62),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Color(0xFFB58A45),
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
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

class _WishlistTag extends StatelessWidget {
  final String text;

  const _WishlistTag({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF29251F),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 7,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}