import 'package:flutter/material.dart';
import '../data/app_theme.dart';
import '../data/travel_data.dart';
import '../models/destination.dart';
import '../widgets/category_chip.dart';
import '../widgets/destination_card.dart';
import '../widgets/section_title.dart';
import 'detail_screen.dart';

// ============================================================
// Home Screen – Complex Dashboard
// Contains: AppBar with icons, search bar (UI only),
// horizontal category scrolling, grid of destination cards.
// Tapping a card navigates to the Detail Screen.
// ============================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  // Navigate to Detail Screen, passing the destination object
  void _openDetail(Destination destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(destination: destination),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---------- AppBar ----------
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {},
        ),
        title: const Text(
          'Explore',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppTheme.primaryColor,
              child: Text('T', style: TextStyle(color: Colors.white, fontSize: 14)),
            ),
          ),
        ],
      ),

      // ---------- Body ----------
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // ---- Greeting ----
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Where do you\nwant to go?', style: AppTheme.headingLarge),
              ),
              const SizedBox(height: 16),

              // ---- Search Bar (UI only) ----
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppTheme.buttonRadius,
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search destinations...',
                      hintStyle: TextStyle(color: AppTheme.textLight),
                      prefixIcon: Icon(Icons.search_rounded, color: AppTheme.textLight),
                      suffixIcon: Icon(Icons.tune_rounded, color: AppTheme.primaryColor),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ---- Category Chips (horizontal scroll) ----
              const SectionTitle(title: 'Categories'),
              const SizedBox(height: 4),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: TravelData.categories.length,
                  itemBuilder: (context, index) {
                    final cat = TravelData.categories[index];
                    return CategoryChip(
                      emoji: cat['icon']!,
                      label: cat['label']!,
                      isSelected: index == _selectedCategoryIndex,
                      onTap: () => setState(() => _selectedCategoryIndex = index),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // ---- Featured Destinations (horizontal scroll) ----
              const SectionTitle(title: 'Featured', actionText: 'See All'),
              const SizedBox(height: 4),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: TravelData.featuredDestinations.length,
                  itemBuilder: (context, index) {
                    final dest = TravelData.featuredDestinations[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: SizedBox(
                        width: 180,
                        child: DestinationCard(
                          destination: dest,
                          onTap: () => _openDetail(dest),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // ---- All Destinations (Grid) ----
              const SectionTitle(title: 'Popular Destinations', actionText: 'See All'),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: TravelData.destinations.length,
                  itemBuilder: (context, index) {
                    final dest = TravelData.destinations[index];
                    return DestinationCard(
                      destination: dest,
                      onTap: () => _openDetail(dest),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      // ---------- Bottom Navigation Bar ----------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textLight,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore_rounded), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: 'Trips'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
