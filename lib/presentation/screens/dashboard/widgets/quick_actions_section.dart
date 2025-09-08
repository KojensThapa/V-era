import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  final Function(BuildContext) onMyCardTap;
  final Function(BuildContext) onCreateCardTap;
  final Function(BuildContext) onWalletTap;
  final Function(BuildContext) onSettingsTap;

  const QuickActionsSection({
    super.key,
    required this.onMyCardTap,
    required this.onCreateCardTap,
    required this.onWalletTap,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildQuickAction(
                'My Card',
                'View & Edit',
                Icons.credit_card,
                const Color(0xFF2563EB),
                () => onMyCardTap(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickAction(
                'Create Card',
                'New Design',
                Icons.add,
                const Color(0xFF10B981),
                () => onCreateCardTap(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildQuickAction(
                'Card Wallet',
                'Manage Cards',
                Icons.account_balance_wallet,
                const Color(0xFF06B6D4),
                () => onWalletTap(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickAction(
                'Settings',
                'Preferences',
                Icons.settings,
                const Color(0xFF8B5CF6),
                () => onSettingsTap(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAction(String title, String subtitle, IconData icon, 
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}