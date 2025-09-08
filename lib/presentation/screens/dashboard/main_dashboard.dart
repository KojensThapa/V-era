import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/providers.dart';
import './widgets/dashboard_header.dart';
import './widgets/stats_section.dart';
import 'widgets/quick_actions_section.dart';
import './widgets/recent_activity_section.dart';
import './widgets/custom_bottom_navigation_bar.dart';
import '../../../services/navigation_service.dart';

class MainDashboard extends ConsumerWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardViewModelProvider);
    final dashboardViewModel = ref.read(dashboardViewModelProvider.notifier);

    // Load data on initial build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (dashboardState.stats == null && !dashboardState.isLoading) {
        dashboardViewModel.loadDashboardData();
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header Section
          const DashboardHeader(),
          
          // Stats Section with loading/error states
          if (dashboardState.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: CircularProgressIndicator(),
            )
          else if (dashboardState.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Error: ${dashboardState.error}',
                style: const TextStyle(color: Colors.red),
              ),
            )
          else if (dashboardState.stats != null)
            StatsSection(stats: dashboardState.stats!),
          
          // Content Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Actions Section
                  QuickActionsSection(
                    onMyCardTap: _navigateToMyCard,
                    onCreateCardTap: _navigateToCreateCard,
                    onWalletTap: _navigateToWallet,
                    onSettingsTap: _navigateToSettings,
                  ),
                  const SizedBox(height: 24),
                  
                  // Recent Activity Section
                  RecentActivitySection(activities: dashboardState.activities),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) => _onBottomNavTap(context, index),
      ),
    );
  }

  // Navigation Methods
  void _navigateToMyCard(BuildContext context) {
    NavigationService.navigateTo(context, '/my-card');
  }

  void _navigateToCreateCard(BuildContext context) {
    NavigationService.navigateTo(context, '/create-card');
  }

  void _navigateToWallet(BuildContext context) {
    NavigationService.navigateTo(context, '/wallet');
  }

  void _navigateToSettings(BuildContext context) {
    NavigationService.navigateTo(context, '/settings');
  }

  void _onBottomNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        NavigationService.navigateTo(context, '/scan');
        break;
      case 2:
        NavigationService.navigateTo(context, '/events');
        break;
      case 3:
        NavigationService.navigateTo(context, '/profile');
        break;
    }
  }
}