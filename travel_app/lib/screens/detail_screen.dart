import 'package:flutter/material.dart';
import '../data/app_theme.dart';
import '../models/destination.dart';
import '../widgets/info_chip.dart';
import '../widgets/rating_stars.dart';
import 'booking_screen.dart';

// ============================================================
// Detail Screen
// Displays: large header image, destination info, scrollable
// description, rating, price, and styled "Book Now" button.
// Uses SingleChildScrollView and custom reusable widgets.
// "Book Now" navigates to the Booking Screen.
// ============================================================

class DetailScreen extends StatelessWidget {
  final Destination destination;

  const DetailScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Large Header Image with overlay controls ----
            _buildHeaderImage(context),
            const SizedBox(height: 20),

            // ---- Destination Title & Location ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(destination.name, style: AppTheme.headingLarge),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 16, color: AppTheme.primaryColor),
                            const SizedBox(width: 4),
                            Text(destination.country, style: AppTheme.bodyText),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Favorite button
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      destination.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ---- Info Chips Row ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  const InfoChip(
                    icon: Icons.access_time_rounded,
                    label: '5 Days',
                  ),
                  InfoChip(
                    icon: Icons.wb_sunny_rounded,
                    label: destination.category,
                    iconColor: AppTheme.accentColor,
                  ),
                  const InfoChip(
                    icon: Icons.group_rounded,
                    label: 'Max 20',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ---- Rating Section ----
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: AppTheme.buttonRadius,
                ),
                child: Row(
                  children: [
                    RatingStars(rating: destination.rating, size: 22),
                    const Spacer(),
                    Text(
                      '(2.4k reviews)',
                      style: AppTheme.caption.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ---- Description ----
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('About', style: AppTheme.headingMedium),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(destination.description, style: AppTheme.bodyText),
            ),
            const SizedBox(height: 20),

            // ---- Highlights ----
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Highlights', style: AppTheme.headingMedium),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: destination.highlights
                    .map((h) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check_rounded,
                                    size: 16, color: AppTheme.primaryColor),
                              ),
                              const SizedBox(width: 12),
                              Expanded(child: Text(h, style: AppTheme.bodyText)),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),

            // ---- Price & Book Button ----
            _buildBookingBar(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ---------- Header Image with back / share buttons ----------
  Widget _buildHeaderImage(BuildContext context) {
    return Stack(
      children: [
        // Large image
        ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
          child: Image.asset(
            destination.imageAsset,
            height: 340,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 340,
              color: AppTheme.primaryColor.withValues(alpha: 0.2),
              child: const Center(child: Icon(Icons.image, size: 64)),
            ),
          ),
        ),
        // Gradient overlay at top for status bar readability
        Container(
          height: 120,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            gradient: LinearGradient(
              colors: [Colors.black38, Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        // Back button
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          child: _circleButton(
            icon: Icons.arrow_back_rounded,
            onTap: () => Navigator.pop(context),
          ),
        ),
        // Share button
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          right: 16,
          child: _circleButton(icon: Icons.share_rounded, onTap: () {}),
        ),
      ],
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          shape: BoxShape.circle,
          boxShadow: AppTheme.cardShadow,
        ),
        child: Icon(icon, size: 22, color: AppTheme.textDark),
      ),
    );
  }

  // ---------- Price bar with "Book Now" button ----------
  Widget _buildBookingBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: AppTheme.cardRadius,
        boxShadow: AppTheme.buttonShadow,
      ),
      child: Row(
        children: [
          // Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 2),
              Text(
                '\$${destination.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'per person',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          // Book Now button → navigates to BookingScreen
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingScreen(destination: destination),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: AppTheme.buttonRadius,
              ),
              elevation: 0,
            ),
            child: const Text(
              'Book Now',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}