import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v_era/presentation/screens/onboarding/view_models/onboarding_view_model.dart';

final onboardingViewModelProvider = StateNotifierProvider<OnboardingViewModel, OnboardingState>((ref) {
  // For now, we'll use mock data. Later you can connect to real data sources
  return OnboardingViewModel();
});