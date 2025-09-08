import 'package:flutter/material.dart';
import 'package:v_era/domain/entities/dashboard_entity.dart';

class RecentActivitySection extends StatelessWidget {
  final List<RecentActivity> activities;

  const RecentActivitySection({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _buildActivityList(activities),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityList(List<RecentActivity> activities) {
    if (activities.isEmpty) {
      return const Center(
        child: Text('No recent activities'),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return _buildActivityItem(
          activity.title,
          activity.time,
          _getIconFromString(activity.icon),
          _getColorFromString(activity.color),
        );
      },
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'share': return Icons.share;
      case 'add': return Icons.add;
      case 'qr_code': return Icons.qr_code;
      case 'person': return Icons.person;
      case 'people': return Icons.people;
      default: return Icons.info;
    }
  }

  Color _getColorFromString(String colorName) {
    switch (colorName) {
      case 'green': return Colors.green;
      case 'blue': return Colors.blue;
      case 'purple': return Colors.purple;
      case 'orange': return Colors.orange;
      case 'indigo': return Colors.indigo;
      default: return Colors.grey;
    }
  }
}