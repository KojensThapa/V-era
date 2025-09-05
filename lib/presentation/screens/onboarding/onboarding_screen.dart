import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v_era/presentation/screens/login/login_screen.dart';
import 'package:v_era/providers/view_models/onboarding_view_model_provider.dart';
import 'package:v_era/domain/entities/onboarding_entity.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late AnimationController _buttonAnimationController;
  
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _pageController = PageController();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _buttonScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _buttonAnimationController, curve: Curves.elasticOut),
    );
    
    _startAnimations();
  }

  void _startAnimations() {
    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      _buttonAnimationController.forward();
    });
  }

  void _restartAnimations() {
    _animationController.reset();
    _buttonAnimationController.reset();
    _startAnimations();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingViewModelProvider);
    final viewModel = ref.read(onboardingViewModelProvider.notifier);
    
    if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    if (state.error != null) {
      return Scaffold(
        body: Center(
          child: Text('Error: ${state.error}'),
        ),
      );
    }
    
    final currentData = viewModel.currentData;
    if (currentData == null || state.data.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No onboarding data available')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF3A4A5C),
      body: Stack(
        children: [
          // Background gradient
          AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF3A4A5C),
                  currentData.gradientColorsAsColor[0].withOpacity(0.1),
                  currentData.gradientColorsAsColor[1].withOpacity(0.05),
                ],
              ),
            ),
          ),
          
          // Background decorative elements
          CustomPaint(
            painter: OnboardingBackgroundPainter(state.currentIndex),
            size: Size.infinite,
          ),
          
          // Main content
          PageView.builder(
            controller: _pageController,
            itemCount: state.data.length,
            onPageChanged: (index) {
              viewModel.setCurrentIndex(index);
              _restartAnimations();
            },
            itemBuilder: (context, index) {
              return _buildOnboardingPage(state.data[index]);
            },
          ),
          
          // Page indicators and navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      state.data.length,
                      (index) => _buildPageIndicator(index, state.currentIndex),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Navigation buttons
                  AnimatedBuilder(
                    animation: _buttonScaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _buttonScaleAnimation.value,
                        child: Row(
                          children: [
                            // Skip button
                            if (state.currentIndex < state.data.length - 1)
                              Expanded(
                                child: TextButton(
                                  onPressed: _navigateToLogin,
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: Text(
                                    'Skip',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            
                            const SizedBox(width: 20),
                            
                            // Next/Get Started button
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: currentData.gradientColorsAsColor,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: currentData.gradientColorsAsColor[0]
                                          .withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: state.currentIndex == state.data.length - 1
                                      ? _navigateToLogin
                                      : _nextPage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    state.currentIndex == state.data.length - 1
                                        ? 'Get Started'
                                        : 'Next',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingEntity data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(height: 80),
          
          // Icon with animation
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _slideAnimation.value),
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: data.gradientColorsAsColor,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: data.gradientColorsAsColor[0].withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Icon(
                      data.iconData,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 60),
          
          // Title with animation
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _slideAnimation.value * 0.8),
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: Text(
                    data.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 30),
          
          // Subtitle with animation
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _slideAnimation.value * 0.6),
                child: Opacity(
                  opacity: _fadeAnimation.value * 0.8,
                  child: Text(
                    data.subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index, int currentIndex) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: currentIndex == index ? 24 : 8,
      decoration: BoxDecoration(
        color: currentIndex == index 
            ? const Color(0xFF00D4AA) 
            : Colors.white30,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class OnboardingBackgroundPainter extends CustomPainter {
  final int currentIndex;
  
  OnboardingBackgroundPainter(this.currentIndex);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Background circles
    final circles = [
      Offset(size.width * 0.1, size.height * 0.2),
      Offset(size.width * 0.9, size.height * 0.3),
      Offset(size.width * 0.2, size.height * 0.8),
      Offset(size.width * 0.8, size.height * 0.1),
    ];

    for (int i = 0; i < circles.length; i++) {
      paint.color = const Color(0xFF00D4AA).withOpacity(0.05 + (i * 0.02));
      canvas.drawCircle(circles[i], 30 + (i * 10), paint);
    }
  }

  @override
  bool shouldRepaint(OnboardingBackgroundPainter oldDelegate) {
    return oldDelegate.currentIndex != currentIndex;
  }
}