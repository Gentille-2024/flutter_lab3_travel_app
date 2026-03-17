import 'package:flutter/material.dart';
import '../data/app_theme.dart';
import '../models/destination.dart';

// ============================================================
// Booking Screen
// Shows: hard-coded booking summary, form-style layout,
// styled confirmation button, and success dialog on confirm.
// ============================================================

class BookingScreen extends StatefulWidget {
  final Destination destination;

  const BookingScreen({super.key, required this.destination});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // Hard-coded form values
  String _selectedDate = 'June 15, 2025';
  int _travelers = 2;
  String _selectedPackage = 'Standard';

  final List<String> _dates = [
    'June 15, 2025',
    'July 01, 2025',
    'July 20, 2025',
    'August 10, 2025',
  ];

  final List<Map<String, dynamic>> _packages = [
    {'name': 'Basic', 'multiplier': 0.8, 'perks': 'Flight + Hotel'},
    {'name': 'Standard', 'multiplier': 1.0, 'perks': 'Flight + Hotel + Tours'},
    {'name': 'Premium', 'multiplier': 1.4, 'perks': 'All-inclusive + VIP'},
  ];

  double get _totalPrice {
    double multiplier = _packages
        .firstWhere((p) => p['name'] == _selectedPackage)['multiplier'];
    return widget.destination.price * _travelers * multiplier;
  }

  // Show success dialog
  void _confirmBooking() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: AppTheme.cardRadius),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded,
                  color: AppTheme.successColor, size: 56),
            ),
            const SizedBox(height: 16),
            const Text('Booking Confirmed!', style: AppTheme.headingMedium),
            const SizedBox(height: 8),
            Text(
              'Your trip to ${widget.destination.name} has been booked '
              'for $_selectedDate.',
              textAlign: TextAlign.center,
              style: AppTheme.bodyText,
            ),
            const SizedBox(height: 8),
            Text(
              'Total: \$${_totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // close dialog
                  Navigator.pop(context); // back to detail
                  Navigator.pop(context); // back to home
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppTheme.buttonRadius,
                  ),
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Also show a SnackBar underneath
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking for ${widget.destination.name} confirmed!'),
        backgroundColor: AppTheme.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppTheme.buttonRadius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---------- AppBar ----------
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Booking', style: TextStyle(fontWeight: FontWeight.bold)),
      ),

      // ---------- Body ----------
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Destination Summary Card ----
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppTheme.cardRadius,
                boxShadow: AppTheme.cardShadow,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: AppTheme.buttonRadius,
                    child: Image.asset(
                      widget.destination.imageAsset,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 80,
                        height: 80,
                        color: AppTheme.primaryColor.withValues(alpha: 0.2),
                        child: const Icon(Icons.image),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.destination.name,
                            style: AppTheme.headingMedium),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 14, color: AppTheme.textLight),
                            const SizedBox(width: 4),
                            Text(widget.destination.country,
                                style: AppTheme.caption),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${widget.destination.price.toStringAsFixed(0)} / person',
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ---- Select Travel Date ----
            const Text('Select Date', style: AppTheme.headingMedium),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppTheme.buttonRadius,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedDate,
                  icon: const Icon(Icons.calendar_month_rounded,
                      color: AppTheme.primaryColor),
                  items: _dates
                      .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedDate = val!),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ---- Number of Travelers ----
            const Text('Travelers', style: AppTheme.headingMedium),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppTheme.buttonRadius,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Number of travelers', style: AppTheme.bodyText),
                  Row(
                    children: [
                      _counterButton(Icons.remove, () {
                        if (_travelers > 1) setState(() => _travelers--);
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '$_travelers',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      _counterButton(Icons.add, () {
                        if (_travelers < 10) setState(() => _travelers++);
                      }),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ---- Package Selection ----
            const Text('Select Package', style: AppTheme.headingMedium),
            const SizedBox(height: 10),
            ...List.generate(_packages.length, (i) {
              final pkg = _packages[i];
              final isSelected = pkg['name'] == _selectedPackage;
              return GestureDetector(
                onTap: () => setState(() => _selectedPackage = pkg['name']),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryColor.withValues(alpha: 0.08)
                        : Colors.white,
                    borderRadius: AppTheme.buttonRadius,
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primaryColor
                          : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: isSelected
                            ? AppTheme.primaryColor
                            : AppTheme.textLight,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pkg['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? AppTheme.primaryColor
                                    : AppTheme.textDark,
                              ),
                            ),
                            Text(pkg['perks'], style: AppTheme.caption),
                          ],
                        ),
                      ),
                      Text(
                        '×${pkg['multiplier']}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppTheme.primaryColor
                              : AppTheme.textMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),

            // ---- Hard-Coded Traveler Info (form-style layout) ----
            const Text('Traveler Info', style: AppTheme.headingMedium),
            const SizedBox(height: 10),
            _readOnlyField('Full Name', 'John Doe'),
            const SizedBox(height: 10),
            _readOnlyField('Email', 'john.doe@email.com'),
            const SizedBox(height: 10),
            _readOnlyField('Phone', '+1 (555) 123-4567'),
            const SizedBox(height: 24),

            // ---- Price Summary ----
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppTheme.cardRadius,
                boxShadow: AppTheme.cardShadow,
              ),
              child: Column(
                children: [
                  _priceRow('Base price', '\$${widget.destination.price.toStringAsFixed(0)}'),
                  _priceRow('Travelers', '×$_travelers'),
                  _priceRow('Package', _selectedPackage),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(
                        '\$${_totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ---- Confirm Button ----
            SizedBox(
              width: double.infinity,
              height: 54,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: AppTheme.buttonRadius,
                  boxShadow: AppTheme.buttonShadow,
                ),
                child: ElevatedButton(
                  onPressed: _confirmBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.buttonRadius,
                    ),
                  ),
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _counterButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: AppTheme.primaryColor),
      ),
    );
  }

  Widget _readOnlyField(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.buttonRadius,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Text(label, style: AppTheme.caption.copyWith(fontSize: 14)),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: AppTheme.textDark)),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTheme.bodyText),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: AppTheme.textDark)),
        ],
      ),
    );
  }
}