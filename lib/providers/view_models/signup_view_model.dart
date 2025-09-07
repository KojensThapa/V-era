import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v_era/data/repositories/auth_repository.dart';

final signupViewModelProvider = StateNotifierProvider<SignupViewModel, SignupState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignupViewModel(authRepository);
});

class SignupViewModel extends StateNotifier<SignupState> {
  final AuthRepository _authRepository;

  SignupViewModel(this._authRepository) : super(SignupState.initial());

  Future<void> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    File? profileImage,
    bool agreeToTerms = true,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // For UI testing, just simulate a successful signup
      await Future.delayed(Duration(seconds: 2)); // Simulate API delay
      
      // Mock successful signup response
      final user = {
        'id': 2, 
        'name': name,
        'email': email,
        'phone': phone,
        'profileImage': profileImage?.path
      };
      
      state = state.copyWith(
        isLoading: false, 
        isSignupSuccessful: true, 
        user: user
      );
      
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void resetSignupStatus() {
    state = state.copyWith(isSignupSuccessful: false);
  }
}

class SignupState {
  final bool isLoading;
  final bool isSignupSuccessful;
  final String? error;
  final dynamic user;

  const SignupState({
    required this.isLoading,
    required this.isSignupSuccessful,
    this.error,
    this.user,
  });

  SignupState.initial()
      : isLoading = false,
        isSignupSuccessful = false,
        error = null,
        user = null;

  SignupState copyWith({
    bool? isLoading,
    bool? isSignupSuccessful,
    String? error,
    dynamic user,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      isSignupSuccessful: isSignupSuccessful ?? this.isSignupSuccessful,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}