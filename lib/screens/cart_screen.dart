import 'package:flutter/material.dart';

import '../data/jewelry_data.dart';
import '../models/jewelry_model.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback onBack;

  const CartScreen({
    super.key,
    required this.onBack,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = JewelryStore.cart;
    final subtotal = JewelryStore.subtotal;
    final shipping = cart.isEmpty ? 0 : 12;
    final total = subtotal + shipping;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EF),
      appBar: AppBar(
        leading: IconButton(
          onPressed: widget.onBack,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text(
          'Your Bag',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: cart.isEmpty
          ? const Center(
        child: Text(
          'Your bag is empty',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF877D73),
          ),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              itemCount: cart.length,
              separatorBuilder: (_, __) =>
              const SizedBox(height: 12),
              itemBuilder: (_, index) {
                final product = cart[index];

                return _CartItem(
                  product: product,
                  onRemove: () {
                    setState(() {
                      JewelryStore.removeFromCart(product.id);
                    });
                  },
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 25),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                _SummaryRow(
                  title: 'Subtotal',
                  value: '\$${subtotal.toStringAsFixed(0)}',
                ),
                const SizedBox(height: 9),
                _SummaryRow(
                  title: 'Shipping',
                  value: '\$${shipping.toStringAsFixed(0)}',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 13),
                  child: Divider(),
                ),
                _SummaryRow(
                  title: 'Total',
                  value: '\$${total.toStringAsFixed(0)}',
                  bold: true,
                ),
                const SizedBox(height: 17),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF292621),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CheckoutScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'PROCEED TO CHECKOUT',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 11,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  final JewelryModel product;
  final VoidCallback onRemove;

  const _CartItem({
    required this.product,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9E1D7)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Image.network(
              product.imageUrl,
              height: 82,
              width: 75,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  height: 82,
                  width: 75,
                  color: const Color(0xFFEDE6DC),
                  child: const Icon(Icons.diamond_outlined),
                );
              },
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category,
                  style: const TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 9,
                    color: Color(0xFFA0825D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.close_rounded,
              size: 19,
              color: Color(0xFF8B8178),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool bold;

  const _SummaryRow({
    required this.title,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: bold ? 14 : 12,
            color: bold ? const Color(0xFF292621) : const Color(0xFF8B8178),
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: bold ? 16 : 12,
            fontWeight: bold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}