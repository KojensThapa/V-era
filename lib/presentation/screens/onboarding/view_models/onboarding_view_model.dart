import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v_era/domain/entities/onboarding_entity.dart';

// States
class OnboardingState {
  final List<OnboardingEntity> data;
  final int currentIndex;
  final bool isLoading;
  final String? error;

  OnboardingState({
    this.data = const [],
    this.currentIndex = 0,
    this.isLoading = false,
    this.error,
  });

  OnboardingState copyWith({
    List<OnboardingEntity>? data,
    int? currentIndex,
    bool? isLoading,
    String? error,
  }) {
    return OnboardingState(
      data: data ?? this.data,
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// ViewModel (extends StateNotifier)
class OnboardingViewModel extends StateNotifier<OnboardingState> {
  OnboardingViewModel() : super(OnboardingState()) {
    loadOnboardingData();
  }

  Future<void> loadOnboardingData() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Mock data - you can replace this with actual API calls later
      final data = [
        OnboardingEntity(
          title: "Digital Networking\nRevolution",
          subtitle: "Transform your professional connections into a paperless, eco-friendly experience",
          iconCode: "network_cell",
          gradientColors: ["0xFF00D4AA", "0xFF26E5D8"],
        ),
        OnboardingEntity(
          title: "Smart Business\nCards",
          subtitle: "Create, share, and manage your digital business cards with advanced analytics and insights",
          iconCode: "badge",
          gradientColors: ["0xFF4ECDC4", "0xFF44A08D"],
        ),
        OnboardingEntity(
          title: "Eco-Friendly\nFuture",
          subtitle: "Join the sustainable revolution and reduce paper waste while building meaningful connections",
          iconCode: "eco",
          gradientColors: ["0xFF667eea", "0xFF764ba2"],
        ),
      ];
      
      state = state.copyWith(data: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void setCurrentIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

  OnboardingEntity? get currentData {
    if (state.data.isEmpty || state.currentIndex >= state.data.length) {
      return null;
    }
    return state.data[state.currentIndex];
  }
}