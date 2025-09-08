class DashboardStatsModel {
  final int cardsCreated;
  final int sharesMade;
  final int connections;

  DashboardStatsModel({
    required this.cardsCreated,
    required this.sharesMade,
    required this.connections,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      cardsCreated: json['cardsCreated'] ?? 0,
      sharesMade: json['sharesMade'] ?? 0,
      connections: json['connections'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardsCreated': cardsCreated,
      'sharesMade': sharesMade,
      'connections': connections,
    };
  }
}