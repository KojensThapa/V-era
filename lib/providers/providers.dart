// export 'package:v_era/data/data_sources/auth_data_source.dart';
// export 'package:v_era/data/repositories/auth_repository.dart';
export 'package:v_era/providers/view_models/auth_view_model.dart';
export 'view_models/signup_view_model.dart';
//main dash board section
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/dashboard_repository_impl.dart';
import '../data/repositories/dashboard_repository.dart';
import './view_models/dashboard_view_model.dart';

// Repository Provider for main dash board
final dashboardRepositoryProvider = Provider<DashboardRepository>(
  (ref) => DashboardRepositoryImpl(),
);

// ViewModel Provider for main dash board
final dashboardViewModelProvider = StateNotifierProvider<DashboardViewModel, DashboardState>(
  (ref) {
    final repository = ref.watch(dashboardRepositoryProvider);
    return DashboardViewModel(repository);
  },
);