import 'package:flutter/material.dart';

class AppDurations {
  static const logoAnimation = Duration(seconds: 1);
  static const textAnimation = Duration(milliseconds: 1000);
  static const dotsAnimation = Duration(seconds: 2);
  static const splashDelay = Duration(seconds: 2);
  static const navigationTransition = Duration(milliseconds: 500);
  static const retryDelay = Duration(milliseconds: 100);
}

class AppColors {
  static const primaryBackground = Color(0xFF3A4A5C);
  static const accentColor = Color(0xFF00D4AA);
  static const white = Colors.white;
  static const white70 = Colors.white70;
  
  static Color accentWithOpacity(double opacity) {
    return accentColor.withOpacity(opacity);
  }
}

class AppSizes {
  static const logoSize = 120.0;
  static const logoBorderWidth = 6.0;
  static const logoInitialScale = 0.5;
  static const logoFinalScale = 1.2;
  static const dotSize = 4.0;
  static const dotSpacing = 8.0;
}