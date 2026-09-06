import 'package:flutter/material.dart';
import '../data/jewelry_data.dart';
import '../models/jewelry_model.dart';
import 'product_detail_screen.dart';

class ProductsScreen extends StatefulWidget {
  final String? initialCategory;

  const ProductsScreen({
    super.key,
    this.initialCategory,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late String selectedCategory;
  String searchQuery = '';
  String sortOption = 'Featured';

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory ?? 'All';
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<JewelryModel> get filteredProducts {
    List<JewelryModel> products = jewelryProducts.where((product) {
      final categoryMatch = selectedCategory == 'All' ||
          product.category == selectedCategory;

      final searchMatch = searchQuery.isEmpty ||
          product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          product.category.toLowerCase().contains(searchQuery.toLowerCase());

      return categoryMatch && searchMatch;
    }).toList();

    if (sortOption == 'Price: Low to High') {
      products.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortOption == 'Price: High to Low') {
      products.sort((a, b) => b.price.compareTo(a.price));
    } else if (sortOption == 'Rating') {
      products.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    final products = filteredProducts;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5EF),
        foregroundColor: const Color(0xFF29251F),
        elevation: 0,
        titleSpacing: 20,
        title: const Text(
          'Jewelry Collection',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showSortSheet,
            icon: const Icon(Icons.tune_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategories(),
          _buildResultHeader(products.length),
          Expanded(
            child: products.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 30),
              itemCount: products.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 18,
                childAspectRatio: 0.67,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return _ProductCard(
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
                  onWishlist: () {
                    setState(() {
                      JewelryStore.toggleWishlist(product);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE5DDD1),
          ),
        ),
        child: TextField(
          controller: searchController,
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          style: const TextStyle(
            color: Color(0xFF29251F),
            fontSize: 14,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: Color(0xFF8B8378),
            ),
            hintText: 'Search jewelry...',
            hintStyle: const TextStyle(
              color: Color(0xFF9A9287),
              fontSize: 14,
            ),
            suffixIcon: searchQuery.isNotEmpty
                ? IconButton(
              onPressed: () {
                searchController.clear();
                setState(() {
                  searchQuery = '';
                });
              },
              icon: const Icon(
                Icons.close_rounded,
                size: 19,
              ),
            )
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: jewelryCategories.length,
        itemBuilder: (context, index) {
          final category = jewelryCategories[index];
          final isSelected = category == selectedCategory;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 9),
              padding: const EdgeInsets.symmetric(horizontal: 17),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF29251F)
                    : Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF29251F)
                      : const Color(0xFFE2D9CC),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF655E55),
                  fontSize: 12,
                  fontWeight:
                  isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultHeader(int count) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
      child: Row(
        children: [
          Text(
            '$count pieces',
            style: const TextStyle(
              color: Color(0xFF29251F),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _showSortSheet,
            child: Row(
              children: [
                const Icon(
                  Icons.swap_vert_rounded,
                  size: 18,
                  color: Color(0xFF8A8175),
                ),
                const SizedBox(width: 4),
                Text(
                  sortOption,
                  style: const TextStyle(
                    color: Color(0xFF746C62),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
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
              width: 85,
              height: 85,
              decoration: const BoxDecoration(
                color: Color(0xFFEDE5D8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 38,
                color: Color(0xFFB58A45),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'No jewelry found',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF29251F),
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Try another search or category.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF81796E),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                searchController.clear();

                setState(() {
                  searchQuery = '';
                  selectedCategory = 'All';
                });
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF29251F),
                side: const BorderSide(
                  color: Color(0xFFD7CBB9),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Clear Filters'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF8F5EF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        final options = [
          'Featured',
          'Price: Low to High',
          'Price: High to Low',
          'Rating',
        ];

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sort Collection',
                  style: TextStyle(
                    color: Color(0xFF29251F),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15),
                ...options.map(
                      (option) {
                    final selected = option == sortOption;

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        setState(() {
                          sortOption = option;
                        });
                        Navigator.pop(context);
                      },
                      title: Text(
                        option,
                        style: TextStyle(
                          color: const Color(0xFF29251F),
                          fontWeight:
                          selected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                      trailing: selected
                          ? const Icon(
                        Icons.check_circle,
                        color: Color(0xFFB58A45),
                      )
                          : const Icon(
                        Icons.radio_button_unchecked,
                        color: Color(0xFFC9BFAF),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final JewelryModel product;
  final VoidCallback onTap;
  final VoidCallback onWishlist;

  const _ProductCard({
    required this.product,
    required this.onTap,
    required this.onWishlist,
  });

  @override
  Widget build(BuildContext context) {
    final isWishlisted = JewelryStore.isWishlisted(product.id);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
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
                  if (product.isNew)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: _Tag(
                        text: 'NEW',
                      ),
                    )
                  else if (product.isBestSeller)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: _Tag(
                        text: 'BEST SELLER',
                      ),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.white.withValues(alpha: 0.92),
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: onWishlist,
                        customBorder: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(9),
                          child: Icon(
                            isWishlisted
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 18,
                            color: isWishlisted
                                ? Colors.redAccent
                                : const Color(0xFF29251F),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(11, 10, 11, 12),
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
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF746C62),
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

class _Tag extends StatelessWidget {
  final String text;

  const _Tag({
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