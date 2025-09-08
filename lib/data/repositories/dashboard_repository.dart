import 'package:dartz/dartz.dart';
import '../../domain/entities/dashboard_entity.dart';

abstract class DashboardRepository {
  Future<Either<String, DashboardStats>> getDashboardStats();
  Future<Either<String, List<RecentActivity>>> getRecentActivities();
}