import 'package:flutter/material.dart';
import 'package:v_era/core/constants/app_constants.dart';

class BackgroundDotsPainter extends CustomPainter {
  final double animationValue;

  BackgroundDotsPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accentWithOpacity(0.2)
      ..style = PaintingStyle.fill;

    final dots = [
      Offset(size.width * 0.1, size.height * 0.2),
      Offset(size.width * 0.9, size.height * 0.3),
      Offset(size.width * 0.2, size.height * 0.7),
      Offset(size.width * 0.8, size.height * 0.8),
      Offset(size.width * 0.15, size.height * 0.5),
      Offset(size.width * 0.85, size.height * 0.6),
    ];

    for (int i = 0; i < dots.length; i++) {
      final opacity = (0.3 + 0.7 * ((animationValue + i * 0.2) % 1.0)).clamp(0.0, 1.0);
      final radius = 3.0 + 2.0 * ((animationValue + i * 0.3) % 1.0);

      paint.color = AppColors.accentWithOpacity(opacity * 0.8);
      canvas.drawCircle(dots[i], radius, paint);
    }
  }

  @override
  bool shouldRepaint(BackgroundDotsPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}