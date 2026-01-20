import 'dart:async';

import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/core/utils/http.dart' as http;
import 'package:expense_tracker/data/models/dashboard_model.dart';

class DashboardRepository {
  Future<DashboardResponse> fetchDashboard(String token) async {
    dynamic jsonResponse = await http.get(
      url: '$baseUrl/api/dashboard',
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );

    return DashboardResponse.fromJson(jsonResponse);
  }
}
