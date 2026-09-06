import 'package:flutter/material.dart';

import '../data/jewelry_data.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String payment = 'Card';

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = JewelryStore.subtotal;
    final total = subtotal + 12;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EF),
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        children: [
          const Text(
            'Delivery details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),

          _InputField(
            controller: nameController,
            hint: 'Full name',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 10),

          _InputField(
            controller: addressController,
            hint: 'Delivery address',
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 10),

          _InputField(
            controller: cityController,
            hint: 'City',
            icon: Icons.location_city_outlined,
          ),

          const SizedBox(height: 25),

          const Text(
            'Payment method',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          _PaymentOption(
            title: 'Credit / Debit Card',
            subtitle: '••••  4821',
            icon: Icons.credit_card_outlined,
            selected: payment == 'Card',
            onTap: () => setState(() => payment = 'Card'),
          ),
          const SizedBox(height: 9),
          _PaymentOption(
            title: 'Cash on Delivery',
            subtitle: 'Pay when your order arrives',
            icon: Icons.payments_outlined,
            selected: payment == 'Cash',
            onTap: () => setState(() => payment = 'Cash'),
          ),

          const SizedBox(height: 25),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
            ),
            child: Column(
              children: [
                _Row(
                  title: 'Items',
                  value: '\$${subtotal.toStringAsFixed(0)}',
                ),
                const SizedBox(height: 9),
                const _Row(
                  title: 'Shipping',
                  value: '\$12',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(),
                ),
                _Row(
                  title: 'Total',
                  value: '\$${total.toStringAsFixed(0)}',
                  bold: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 57,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF292621),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OrderSuccessScreen(),
                  ),
                );
              },
              child: const Text(
                'PLACE ORDER',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? const Color(0xFFB08D57)
                : const Color(0xFFE7DFD5),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: const Color(0xFFF2EADF),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                icon,
                size: 21,
                color: const Color(0xFF987448),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 10,
                      color: Color(0xFF91877D),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected
                  ? const Color(0xFF9D7748)
                  : const Color(0xFFB5ACA2),
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String title;
  final String value;
  final bool bold;

  const _Row({
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
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: bold
                ? const Color(0xFF292621)
                : const Color(0xFF8C8278),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: bold ? 16 : 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}