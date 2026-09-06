import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 92,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF26231F) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected
                ? const Color(0xFF26231F)
                : const Color(0xFFE4DED4),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: selected
                  ? const Color(0xFFD8B477)
                  : const Color(0xFF6F675D),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : const Color(0xFF4B453E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}