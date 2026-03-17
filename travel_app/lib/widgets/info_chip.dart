import 'package:flutter/material.dart';
import '../data/app_theme.dart';

// ============================================================
// Reusable widget: Small info chip (icon + label)
// Used on the Detail Screen for quick facts
// ============================================================

class InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? iconColor;

  const InfoChip({
    super.key,
    required this.icon,
    required this.label,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.chipRadius,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor ?? AppTheme.primaryColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppTheme.textMedium,
            ),
          ),
        ],
      ),
    );
  }
}
