import 'package:flutter/material.dart';

import '../data/jewelry_data.dart';
import 'home_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EF),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 105,
                  width: 105,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8D9C4),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 55,
                    color: Color(0xFF80613D),
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Order confirmed',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Thank you for choosing Lustre.\nYour jewelry is being prepared with care.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 13,
                    height: 1.6,
                    color: Color(0xFF82786E),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'ORDER NUMBER',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 9,
                          letterSpacing: 1.5,
                          color: Color(0xFF9A8F84),
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        '#LS-28491',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
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
                      JewelryStore.cart.clear();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(),
                        ),
                            (route) => false,
                      );
                    },
                    child: const Text(
                      'CONTINUE SHOPPING',
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
        ),
      ),
    );
  }
}