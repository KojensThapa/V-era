class DashboardStats {
  final int cardsCreated;
  final int sharesMade;
  final int connections;

  DashboardStats({
    required this.cardsCreated,
    required this.sharesMade,
    required this.connections,
  });

  DashboardStats copyWith({
    int? cardsCreated,
    int? sharesMade,
    int? connections,
  }) {
    return DashboardStats(
      cardsCreated: cardsCreated ?? this.cardsCreated,
      sharesMade: sharesMade ?? this.sharesMade,
      connections: connections ?? this.connections,
    );
  }
}

class RecentActivity {
  final String title;
  final String time;
  final String icon;
  final String color;

  RecentActivity({
    required this.title,
    required this.time,
    required this.icon,
    required this.color,
  });
}