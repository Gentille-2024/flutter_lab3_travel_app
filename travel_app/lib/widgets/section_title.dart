import 'package:flutter/material.dart';
import '../data/app_theme.dart';

// ============================================================
// Reusable widget: Section heading with optional "See All" link
// Used on the Home Screen for section titles
// ============================================================

class SectionTitle extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onAction;

  const SectionTitle({
    super.key,
    required this.title,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTheme.headingMedium),
          if (actionText != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionText!,
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
