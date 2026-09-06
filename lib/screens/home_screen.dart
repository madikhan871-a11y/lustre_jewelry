import 'package:flutter/material.dart';
import '../data/jewelry_data.dart';
import '../models/jewelry_model.dart';
import 'product_detail_screen.dart';
import 'products_screen.dart';
import 'wishlist_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategory = 0;

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Rings',
      'icon': Icons.circle_outlined,
    },
    {
      'name': 'Necklaces',
      'icon': Icons.auto_awesome_outlined,
    },
    {
      'name': 'Earrings',
      'icon': Icons.diamond_outlined,
    },
    {
      'name': 'Bracelets',
      'icon': Icons.watch_outlined,
    },
  ];

  void _openProducts({String? category}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductsScreen(
          initialCategory: category,
        ),
      ),
    );
  }

  void _openWishlist() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const WishlistScreen(),
      ),
    );
  }

  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartScreen(onBack: () {  },),
      ),
    );
  }

  void _openProduct(JewelryModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          jewelry: product,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final featuredProducts = jewelryProducts
        .where(
          (product) => product.isBestSeller || product.isNew,
    )
        .take(4)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EF),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: _buildHeader(),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: _buildSearchBar(),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
                child: _buildHeroBanner(),
              ),
            ),

            // SHOP BY CATEGORY
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 14),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Shop by Category',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF29251F),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _openProducts(),
                      child: const Text(
                        'View all',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFB58A45),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // CATEGORIES
            SliverToBoxAdapter(
              child: SizedBox(
                height: 112,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    return _CategoryItem(
                      name: category['name'] as String,
                      icon: category['icon'] as IconData,
                      selected: selectedCategory == index,
                      onTap: () {
                        setState(() {
                          selectedCategory = index;
                        });

                        _openProducts(
                          category:
                          category['name'] as String,
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            // FEATURED TITLE
            SliverToBoxAdapter(
              child: Padding(
                padding:
                const EdgeInsets.fromLTRB(20, 30, 20, 14),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Featured Pieces',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF29251F),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _openProducts(),
                      child: const Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFB58A45),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // FEATURED PRODUCTS
            SliverToBoxAdapter(
              child: SizedBox(
                height: 330,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredProducts.length,
                  itemBuilder: (context, index) {
                    final product = featuredProducts[index];

                    return _FeaturedProductCard(
                      product: product,
                      onTap: () => _openProduct(product),
                    );
                  },
                ),
              ),
            ),

            // NEW ARRIVALS
            SliverToBoxAdapter(
              child: Padding(
                padding:
                const EdgeInsets.fromLTRB(20, 32, 20, 15),
                child: const Text(
                  'New Arrivals',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF29251F),
                  ),
                ),
              ),
            ),

            // NEW ARRIVALS GRID
            SliverPadding(
              padding:
              const EdgeInsets.fromLTRB(20, 0, 20, 35),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final product = jewelryProducts[index];

                    return _SmallProductCard(
                      product: product,
                      onTap: () => _openProduct(product),
                    );
                  },
                  childCount: jewelryProducts.length > 4
                      ? 4
                      : jewelryProducts.length,
                ),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.72,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Text(
                'LUSTRE',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                  color: Color(0xFFB58A45),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Find your sparkle',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF29251F),
                ),
              ),
            ],
          ),
        ),

        _CircleButton(
          icon: Icons.favorite_border,
          onTap: _openWishlist,
        ),

        const SizedBox(width: 10),

        Stack(
          clipBehavior: Clip.none,
          children: [
            _CircleButton(
              icon: Icons.shopping_bag_outlined,
              onTap: _openCart,
            ),
            if (JewelryStore.cart.isNotEmpty)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFFB58A45),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    JewelryStore.cart.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () => _openProducts(),
      child: Container(
        height: 54,
        padding:
        const EdgeInsets.symmetric(horizontal: 17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: const Color(0xFFE6DED2),
          ),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.search_rounded,
              color: Color(0xFF8B8378),
              size: 22,
            ),
            SizedBox(width: 11),
            Text(
              'Search jewelry...',
              style: TextStyle(
                color: Color(0xFF9B9388),
                fontSize: 14,
              ),
            ),
            Spacer(),
            Icon(
              Icons.tune_rounded,
              color: Color(0xFFB58A45),
              size: 21,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE8D6B8),
            Color(0xFFD1B07A),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -35,
            top: -25,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white24,
                  width: 22,
                ),
              ),
            ),
          ),

          Positioned(
            right: 22,
            bottom: 18,
            child: Icon(
              Icons.diamond_outlined,
              size: 82,
              color:
              Colors.white.withValues(alpha: 0.72),
            ),
          ),

          const Positioned(
            left: 22,
            top: 25,
            child: Text(
              'TIMELESS\nELEGANCE',
              style: TextStyle(
                fontSize: 27,
                height: 1.05,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                color: Color(0xFF29251F),
              ),
            ),
          ),

          Positioned(
            left: 22,
            bottom: 24,
            child: ElevatedButton(
              onPressed: () => _openProducts(),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF29251F),
                foregroundColor: Colors.white,
                elevation: 0,
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 11,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Explore Collection',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: 0,
      backgroundColor: Colors.white,
      elevation: 0,
      indicatorColor:
      const Color(0xFFEDE2D0),
      onDestinationSelected: (index) {
        if (index == 1) {
          _openWishlist();
        } else if (index == 2) {
          _openCart();
        } else if (index == 3) {
          _openProducts();
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: 'Wishlist',
        ),
        NavigationDestination(
          icon: Icon(Icons.shopping_bag_outlined),
          selectedIcon:
          Icon(Icons.shopping_bag),
          label: 'Bag',
        ),
        NavigationDestination(
          icon: Icon(Icons.grid_view_rounded),
          selectedIcon:
          Icon(Icons.grid_view_rounded),
          label: 'Shop',
        ),
      ],
    );
  }
}

// ============================================================
// CIRCLE BUTTON
// ============================================================

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xFFE6DED2),
          ),
        ),
        child: Icon(
          icon,
          size: 21,
          color: const Color(0xFF29251F),
        ),
      ),
    );
  }
}

// ============================================================
// CATEGORY ITEM
// ============================================================

class _CategoryItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.name,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 82,
        margin:
        const EdgeInsets.only(right: 13),
        child: Column(
          children: [
            AnimatedContainer(
              duration:
              const Duration(milliseconds: 200),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF29251F)
                    : const Color(0xFFEDE5D8),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: selected
                    ? const Color(0xFFE2B96B)
                    : const Color(0xFF8D7552),
                size: 27,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected
                    ? FontWeight.w700
                    : FontWeight.w500,
                color:
                const Color(0xFF29251F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// FEATURED PRODUCT CARD
// ============================================================

class _FeaturedProductCard extends StatelessWidget {
  final JewelryModel product;
  final VoidCallback onTap;

  const _FeaturedProductCard({
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        margin:
        const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(21),
          border: Border.all(
            color: const Color(0xFFE9E0D4),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) {
                      return Container(
                        color:
                        const Color(0xFFEDE5D8),
                        child: const Icon(
                          Icons.diamond_outlined,
                          size: 55,
                          color:
                          Color(0xFFB58A45),
                        ),
                      );
                    },
                  ),
                ),

                if (product.isNew)
                  const Positioned(
                    top: 12,
                    left: 12,
                    child: _Badge(
                      text: 'NEW',
                    ),
                  ),

                if (product.isBestSeller)
                  const Positioned(
                    top: 12,
                    right: 12,
                    child: _Badge(
                      text: 'BEST SELLER',
                    ),
                  ),
              ],
            ),

            Padding(
              padding:
              const EdgeInsets.fromLTRB(
                14,
                13,
                14,
                14,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.w700,
                      color:
                      Color(0xFF29251F),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 15,
                        color:
                        Color(0xFFD09A3A),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style:
                        const TextStyle(
                          fontSize: 12,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${product.price.toStringAsFixed(0)}',
                        style:
                        const TextStyle(
                          fontSize: 16,
                          fontWeight:
                          FontWeight.w800,
                          color:
                          Color(0xFF29251F),
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

// ============================================================
// SMALL PRODUCT CARD
// ============================================================

class _SmallProductCard extends StatelessWidget {
  final JewelryModel product;
  final VoidCallback onTap;

  const _SmallProductCard({
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE9E0D4),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) {
                  return Container(
                    color:
                    const Color(0xFFEDE5D8),
                    child: const Icon(
                      Icons.diamond_outlined,
                      size: 45,
                      color:
                      Color(0xFFB58A45),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding:
              const EdgeInsets.fromLTRB(
                12,
                10,
                12,
                12,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight:
                      FontWeight.w700,
                      color:
                      Color(0xFF29251F),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '\$${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w800,
                      color:
                      Color(0xFFB58A45),
                    ),
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

// ============================================================
// BADGE
// ============================================================

class _Badge extends StatelessWidget {
  final String text;

  const _Badge({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF29251F),
        borderRadius:
        BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}