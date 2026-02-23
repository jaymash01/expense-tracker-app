import 'dart:async';

import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/core/network/dio_client.dart' as dio;
import 'package:expense_tracker/data/models/dashboard_model.dart';

class DashboardRepository {
  Future<DashboardResponse> fetchDashboard() async {
    dynamic jsonResponse = await dio.get(url: '/api/dashboard');

    return DashboardResponse.fromJson(jsonResponse);
  }
}
