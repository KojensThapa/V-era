import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/dashboard_entity.dart';
import '../../data/repositories/dashboard_repository.dart';

class DashboardViewModel extends StateNotifier<DashboardState> {
  final DashboardRepository repository;

  DashboardViewModel(this.repository) : super(DashboardState.initial());

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);

    final statsResult = await repository.getDashboardStats();
    final activitiesResult = await repository.getRecentActivities();

    statsResult.fold(
      (error) => state = state.copyWith(error: error, isLoading: false),
      (stats) => state = state.copyWith(stats: stats, isLoading: false),
    );

    activitiesResult.fold(
      (error) => state = state.copyWith(error: error, isLoading: false),
      (activities) => state = state.copyWith(activities: activities, isLoading: false),
    );
  }

  void refreshData() {
    loadDashboardData();
  }
}

class DashboardState {
  final DashboardStats? stats;
  final List<RecentActivity> activities;
  final bool isLoading;
  final String? error;

  DashboardState({
    this.stats,
    this.activities = const [],
    this.isLoading = false,
    this.error,
  });

  DashboardState.initial() : this();

  DashboardState copyWith({
    DashboardStats? stats,
    List<RecentActivity>? activities,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      stats: stats ?? this.stats,
      activities: activities ?? this.activities,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}