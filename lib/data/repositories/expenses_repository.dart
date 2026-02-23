import 'dart:async';

import 'package:expense_tracker/core/network/dio_client.dart' as dio;
import 'package:expense_tracker/data/models/expense_model.dart';

class ExpensesRepository {
  Future<CreateExpenseResponse> createExpense(Map<String, dynamic> body) async {
    dynamic jsonResponse = await dio.post(url: '/api/expenses', body: body);

    return CreateExpenseResponse.fromJson(jsonResponse);
  }

  Future<ExpensesResponse> fetchExpenses(Map<String, dynamic>? params) async {
    dynamic jsonResponse = await dio.get(url: '/api/expenses', params: params);

    return ExpensesResponse.fromJson(jsonResponse);
  }

  Future<ExpenseDetailsResponse> fetchExpenseDetails(int id) async {
    dynamic jsonResponse = await dio.get(url: '/api/expenses/$id');

    return ExpenseDetailsResponse.fromJson(jsonResponse);
  }

  Future<UpdateExpenseResponse> updateExpense(
    int id,
    Map<String, dynamic> body,
  ) async {
    dynamic jsonResponse = await dio.patch(
      url: '/api/expenses/$id',
      body: body,
    );

    return UpdateExpenseResponse.fromJson(jsonResponse);
  }

  Future<String> deleteExpense(int id) async {
    dynamic jsonResponse = await dio.delete(url: '/api/expenses/$id');

    return jsonResponse['message'];
  }
}
