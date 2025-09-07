import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v_era/data/repositories/auth_repository.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthViewModel(authRepository);
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) : super(AuthState.initial());

  Future<void> login(String email, String password, bool rememberMe) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final user = await _authRepository.login(email, password, rememberMe);
      state = state.copyWith(isLoading: false, isAuthenticated: true, user: user);
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? error;
  final dynamic user; // Replace with your User model

  const AuthState({
    required this.isLoading,
    required this.isAuthenticated,
    this.error,
    this.user,
  });

  AuthState.initial()
      : isLoading = false,
        isAuthenticated = false,
        error = null,
        user = null;

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
    dynamic user,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}