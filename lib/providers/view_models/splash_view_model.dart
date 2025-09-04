import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v_era/data/repositories/app_repository.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, bool>((ref) {
  return SplashViewModel(ref);
});

class SplashViewModel extends StateNotifier<bool> {
  final Ref ref;
  
  SplashViewModel(this.ref) : super(false);

  Future<Map<String, bool>> initializeApp() async {
    final appRepository = ref.read(appRepositoryProvider);

    final isFirstTime = await appRepository.checkFirstTime();
    final isLoggedIn = await appRepository.checkLoginStatus();

    state = true;

    return {
      'isFirstTime': isFirstTime,
      'isLoggedIn': isLoggedIn,
    };
  }
}

final appRepositoryProvider = Provider<AppRepository>((ref) {
  return AppRepository();
});