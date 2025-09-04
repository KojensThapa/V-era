import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v_era/core/constants/app_constants.dart';

class SplashLogo extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> opacityAnimation;

  const SplashLogo({
    super.key,
    required this.scaleAnimation,
    required this.opacityAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: Opacity(
            opacity: opacityAnimation.value,
            child: Container(
              width: AppSizes.logoSize,
              height: AppSizes.logoSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.accentColor,
                  width: AppSizes.logoBorderWidth,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentWithOpacity(0.3),
                    blurRadius: 20 + (scaleAnimation.value - 0.5) * 20,
                    spreadRadius: 5 + (scaleAnimation.value - 0.5) * 10,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'V',
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBackground,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SplashText extends StatelessWidget {
  final Animation<double> fadeAnimation;

  const SplashText({super.key, required this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: fadeAnimation.value,
          child: Column(
            children: [
              Text(
                'V-era',
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 20),
              Opacity(
                opacity: fadeAnimation.value * 0.8,
                child: Text(
                  'Digital Networking Revolution',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accentColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Opacity(
                opacity: fadeAnimation.value * 0.6,
                child: const FeatureTagsRow(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FeatureTagsRow extends StatelessWidget {
  const FeatureTagsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFeatureText('Eco-Friendly'),
        _buildDot(),
        _buildFeatureText('Paperless'),
        _buildDot(),
        _buildFeatureText('Future'),
      ],
    );
  }

  Widget _buildFeatureText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.white70,
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.dotSpacing),
      width: AppSizes.dotSize,
      height: AppSizes.dotSize,
      decoration: const BoxDecoration(
        color: AppColors.accentColor,
        shape: BoxShape.circle,
      ),
    );
  }
}