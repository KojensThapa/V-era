import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:v_era/core/constants/app_constants.dart';

class SplashAnimations {
  final TickerProvider vsync;
  
  late AnimationController logoController;
  late AnimationController textController;
  late AnimationController dotsController;
  
  late Animation<double> logoScaleAnimation;
  late Animation<double> logoOpacityAnimation;
  late Animation<double> textFadeAnimation;
  late Animation<double> dotsAnimation;
  
  SplashAnimations({required this.vsync}) {
    _initControllers();
    _initAnimations();
  }
  
  void _initControllers() {
    logoController = AnimationController(
      duration: AppDurations.logoAnimation,
      vsync: vsync,
    );
    
    textController = AnimationController(
      duration: AppDurations.textAnimation,
      vsync: vsync,
    );
    
    dotsController = AnimationController(
      duration: AppDurations.dotsAnimation,
      vsync: vsync,
    );
  }
  
  void _initAnimations() {
    logoScaleAnimation = Tween<double>(
      begin: AppSizes.logoInitialScale,
      end: AppSizes.logoFinalScale,
    ).animate(CurvedAnimation(
      parent: logoController,
      curve: Curves.easeOut,
    ));
    
    logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: logoController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
    ));
    
    textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: textController,
      curve: Curves.easeIn,
    ));
    
    dotsAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: dotsController,
      curve: Curves.easeInOut,
    ));
  }
  
  void start() {
    logoController.forward();
    Future.delayed(const Duration(seconds: 2), () {
      textController.forward();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      dotsController.repeat();
    });
  }
  
  void dispose() {
    logoController.dispose();
    textController.dispose();
    dotsController.dispose();
  }
}