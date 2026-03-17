import 'package:flutter/material.dart';
import '../data/app_theme.dart';

// ============================================================
// Reusable widget: displays star rating with numeric value
// Used on both the Home Screen cards and the Detail Screen
// ============================================================

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final bool showLabel;

  const RatingStars({
    super.key,
    required this.rating,
    this.size = 18,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalf = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Full stars
        for (int i = 0; i < fullStars; i++)
          Icon(Icons.star_rounded, color: AppTheme.starColor, size: size),
        // Half star
        if (hasHalf)
          Icon(Icons.star_half_rounded, color: AppTheme.starColor, size: size),
        // Empty stars
        for (int i = 0; i < 5 - fullStars - (hasHalf ? 1 : 0); i++)
          Icon(Icons.star_border_rounded, color: AppTheme.starColor, size: size),
        if (showLabel) ...[
          const SizedBox(width: 6),
          Text(
            rating.toString(),
            style: TextStyle(
              fontSize: size * 0.75,
              fontWeight: FontWeight.w600,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ],
    );
  }
}
