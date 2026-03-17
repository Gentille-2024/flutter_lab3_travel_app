import 'package:flutter/material.dart';
import '../data/app_theme.dart';

// ============================================================
// Reusable widget: Category chip for horizontal scrolling list
// Shows an emoji icon and label inside a styled container
// ============================================================

class CategoryChip extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.emoji,
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.white,
          borderRadius: AppTheme.chipRadius,
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryColor
                : Colors.grey.shade300,
          ),
          boxShadow: isSelected ? AppTheme.buttonShadow : [],
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppTheme.textMedium,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
