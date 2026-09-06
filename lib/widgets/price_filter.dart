import 'package:flutter/material.dart';

class PriceFilter extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const PriceFilter({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE8E0D5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                'Maximum price',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Text(
                '\$1,000',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9B784B),
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: 100,
            max: 1000,
            divisions: 18,
            activeColor: const Color(0xFFB08D57),
            inactiveColor: const Color(0xFFE6DED3),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}