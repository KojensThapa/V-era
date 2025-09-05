import 'package:flutter/material.dart';

class OnboardingEntity {
  final String title;
  final String subtitle;
  final String iconCode; // Store icon as code
  final List<String> gradientColors; // Store colors as strings

  OnboardingEntity({
    required this.title,
    required this.subtitle,
    required this.iconCode,
    required this.gradientColors,
  });

  // Helper method to convert icon code to IconData
  IconData get iconData {
    switch (iconCode) {
      case "network_cell":
        return Icons.network_cell;
      case "badge":
        return Icons.badge_outlined;
      case "eco":
        return Icons.eco_outlined;
      default:
        return Icons.help_outline;
    }
  }

  // Helper method to convert to Color objects
  List<Color> get gradientColorsAsColor {
    return gradientColors.map((color) => Color(int.parse(color))).toList();
  }
}