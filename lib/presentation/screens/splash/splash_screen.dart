import 'package:flutter/material.dart' hide NavigationDestination;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v_era/presentation/screens/onboarding_screen.dart';
import 'package:v_era/presentation/screens/main_dashboard.dart';
import 'package:v_era/providers/navigation_providers.dart';
import 'package:v_era/core/constants/app_constants.dart';
import 'package:v_era/presentation/screens/splash/splash_animations.dart';
import 'package:v_era/presentation/screens/splash/splash_background.dart';
import 'package:v_era/presentation/screens/splash/splash_content.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late SplashAnimations animations;

  @override
  void initState() {
    super.initState();
    animations = SplashAnimations(vsync: this);
    animations.start();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(AppDurations.splashDelay, () {
      if (!mounted) return;

      final navigationAsyncValue = ref.read(navigationProvider);
      
      navigationAsyncValue.when(
        data: (destination) => _handleNavigation(destination),
        loading: () => _retryNavigation(),
        error: (error, stack) => _handleError(),
      );
    });
  }

  void _handleNavigation(NavigationDestination destination) {
    Widget nextScreen;
    switch (destination) {
      case NavigationDestination.onboarding:
        nextScreen = const OnboardingScreen();
        break;
      case NavigationDestination.auth:
        nextScreen = const OnboardingScreen(); // Replace with AuthScreen when available
        break;
      case NavigationDestination.dashboard:
        nextScreen = const MainDashboard();
        break;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionDuration: AppDurations.navigationTransition,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  void _retryNavigation() {
    Future.delayed(AppDurations.retryDelay, () {
      if (mounted) _navigateToNextScreen();
    });
  }

  void _handleError() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),
          transitionDuration: AppDurations.navigationTransition,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    animations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: animations.dotsAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: BackgroundDotsPainter(animations.dotsAnimation.value),
                size: Size.infinite,
              );
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SplashLogo(
                  scaleAnimation: animations.logoScaleAnimation,
                  opacityAnimation: animations.logoOpacityAnimation,
                ),
                const SizedBox(height: 40),
                SplashText(fadeAnimation: animations.textFadeAnimation),
              ],
            ),
          ),
        ],
      ),
    );
  }
}