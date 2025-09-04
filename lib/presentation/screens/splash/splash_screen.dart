import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v_era/providers/view_models/splash_view_model.dart';

// Import your next screens here
import 'package:v_era/presentation/screens/onboarding/onboarding_screen.dart';
// import 'package:v_era/presentation/screens/auth/auth_screen.dart';
import 'package:v_era/presentation/screens/dashboard/main_dashboard.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> 
    with TickerProviderStateMixin {
  
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _dotsController;
  
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _dotsAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
    _navigateToNextScreen();
  }

  void _initializeAnimations() {
    // Logo animations - will grow continuously for 2 seconds
    _logoController = AnimationController(
      duration: const Duration(seconds: 2), // 2 seconds total growth
      vsync: this,
    );
    
    _logoScaleAnimation = Tween<double>(
      begin: 0.5, // Start small
      end: 1.2,   // End larger
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOut,
    ));
    
    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeIn), // Fade in quickly
    ));

    // Text animations
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    ));

    // Dots animation
    _dotsController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _dotsAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _dotsController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() {
    // Start logo growing animation
    _logoController.forward();
    
    // After logo finishes growing (2 seconds), start text animations
    Future.delayed(const Duration(seconds: 2), () {
      _textController.forward();
    });
    
    // Start background dots early
    Future.delayed(const Duration(milliseconds: 500), () {
      _dotsController.repeat();
    });
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 4)); // Total 4 seconds: 2s logo + 2s text
    
    // Use Riverpod to check app state
    final appState = await ref.read(splashViewModelProvider.notifier).initializeApp();
    final isFirstTime = appState['isFirstTime'] ?? true;
    final isLoggedIn = appState['isLoggedIn'] ?? false;
    
    if (!mounted) return;
    
    Widget nextScreen;
    if (isFirstTime) {
      // Navigate to onboarding
      nextScreen = const OnboardingScreen();
    } else if (!isLoggedIn) {
      // Navigate to login/signup
      // nextScreen = const AuthScreen();
      nextScreen = const OnboardingScreen(); // Replace with AuthScreen when created
    } else {
      // Navigate to main dashboard
      nextScreen = const MainDashboard();
    }
    
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A4A5C), // Dark blue-gray background
      body: Stack(
        children: [
          // Animated background dots
          AnimatedBuilder(
            animation: _dotsAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: BackgroundDotsPainter(_dotsAnimation.value),
                size: Size.infinite,
              );
            },
          ),
          
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with animation
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _logoScaleAnimation.value,
                      child: Opacity(
                        opacity: _logoOpacityAnimation.value,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFF00D4AA), // Teal color
                              width: 6,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF00D4AA).withOpacity(0.3),
                                blurRadius: 20 + (_logoScaleAnimation.value - 0.5) * 20, // Shadow grows with logo
                                spreadRadius: 5 + (_logoScaleAnimation.value - 0.5) * 10,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'V',
                              style: GoogleFonts.poppins(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3A4A5C),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 40),
                
                // App name with animation
                AnimatedBuilder(
                  animation: _textFadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textFadeAnimation.value,
                      child: Text(
                        'V-era',
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2.0,
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Subtitle with animation
                AnimatedBuilder(
                  animation: _textFadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textFadeAnimation.value * 0.8,
                      child: Text(
                        'Digital Networking Revolution',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF00D4AA),
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 30),
                
                // Bottom text with animation
                AnimatedBuilder(
                  animation: _textFadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textFadeAnimation.value * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildFeatureText('Eco-Friendly'),
                          _buildDot(),
                          _buildFeatureText('Paperless'),
                          _buildDot(),
                          _buildFeatureText('Future'),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        color: Color(0xFF00D4AA),
        shape: BoxShape.circle,
      ),
    );
  }
}

class BackgroundDotsPainter extends CustomPainter {
  final double animationValue;
  
  BackgroundDotsPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00D4AA).withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw animated dots in background
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
      
      paint.color = const Color(0xFF00D4AA).withOpacity(opacity * 0.2);
      canvas.drawCircle(dots[i], radius, paint);
    }
  }

  @override
  bool shouldRepaint(BackgroundDotsPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}