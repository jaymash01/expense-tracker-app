import 'dart:async';

import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/core/utils/http.dart' as http;
import 'package:expense_tracker/data/models/expense_model.dart';

class ExpensesRepository {
  Future<CreateExpenseResponse> createExpense(
    String token,
    Map<String, dynamic> body,
  ) async {
    dynamic jsonResponse = await http.post(
      url: '$baseUrl/api/expenses',
      body: body,
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );

    return CreateExpenseResponse.fromJson(jsonResponse);
  }

  Future<ExpensesResponse> fetchExpenses(
    String token,
    Map<String, dynamic>? params,
  ) async {
    dynamic jsonResponse = await http.get(
      url: '$baseUrl/api/expenses',
      params: params,
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );

    return ExpensesResponse.fromJson(jsonResponse);
  }

  Future<ExpenseDetailsResponse> fetchExpenseDetails(
    String token,
    int id,
  ) async {
    dynamic jsonResponse = await http.get(
      url: '$baseUrl/api/expenses/$id',
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );

    return ExpenseDetailsResponse.fromJson(jsonResponse);
  }

  Future<DeleteExpenseResponse> deleteExpense(String token, int id) async {
    dynamic jsonResponse = await http.delete(
      url: '$baseUrl/api/expenses/$id',
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );

    return DeleteExpenseResponse.fromJson(jsonResponse);
  }
}
