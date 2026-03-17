import 'package:flutter/material.dart';
import '../data/app_theme.dart';
import '../models/destination.dart';
import 'rating_stars.dart';

// ============================================================
// Reusable widget: Destination card for the Home Screen grid
// Uses Stack, Positioned, Container with decoration, Card
// Tapping navigates to the Detail Screen
// ============================================================

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onTap;

  const DestinationCard({
    super.key,
    required this.destination,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppTheme.cardRadius,
          boxShadow: AppTheme.cardShadow,
          color: AppTheme.cardColor,
        ),
        child: ClipRRect(
          borderRadius: AppTheme.cardRadius,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- Image with overlay & favorite icon ----
              Expanded(
                flex: 3,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background image
                    Image.asset(
                      destination.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppTheme.primaryColor.withValues(alpha: 0.2),
                        child: const Icon(Icons.image, size: 48),
                      ),
                    ),
                    // Gradient overlay
                    Container(
                      decoration: const BoxDecoration(
                        gradient: AppTheme.cardOverlayGradient,
                      ),
                    ),
                    // Favorite icon (top-right)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.85),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          destination.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: destination.isFavorite
                              ? Colors.redAccent
                              : AppTheme.textLight,
                          size: 18,
                        ),
                      ),
                    ),
                    // Category chip (top-left)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor,
                          borderRadius: AppTheme.chipRadius,
                        ),
                        child: Text(
                          destination.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    // Price tag (bottom-left on image)
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: AppTheme.chipRadius,
                        ),
                        child: Text(
                          '\$${destination.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: AppTheme.primaryDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ---- Text content below image ----
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppTheme.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: AppTheme.textLight,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              destination.country,
                              style: AppTheme.caption,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      RatingStars(rating: destination.rating, size: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}