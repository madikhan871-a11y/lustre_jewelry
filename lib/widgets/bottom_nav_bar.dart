import 'package:flutter/material.dart';

class JewelryBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const JewelryBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.home_outlined, 'Home'),
      (Icons.explore_outlined, 'Explore'),
      (Icons.favorite_border_rounded, 'Saved'),
      (Icons.shopping_bag_outlined, 'Bag'),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      decoration: const BoxDecoration(
        color: Color(0xFFFDFBF8),
        border: Border(
          top: BorderSide(color: Color(0xFFE8E0D5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final selected = index == currentIndex;

          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 9,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFEDE2D2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    items[index].$1,
                    size: 22,
                    color: selected
                        ? const Color(0xFF8E683C)
                        : const Color(0xFF8B837A),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    items[index].$2,
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 9,
                      fontWeight:
                      selected ? FontWeight.bold : FontWeight.normal,
                      color: selected
                          ? const Color(0xFF725330)
                          : const Color(0xFF8B837A),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}