import 'dart:async';

import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/core/utils/http.dart' as http;
import 'package:expense_tracker/data/models/category_model.dart';

class CategoriesRepository {
  Future<CreateCategoryResponse> createCategory(
    String token,
    Map<String, dynamic> body,
  ) async {
    dynamic jsonResponse = await http.post(
      url: '$baseUrl/api/categories',
      body: body,
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );

    return CreateCategoryResponse.fromJson(jsonResponse);
  }

  Future<CategoriesResponse> fetchCategories(
    String token,
    Map<String, dynamic>? params,
  ) async {
    dynamic jsonResponse = await http.get(
      url: '$baseUrl/api/categories',
      params: params,
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );

    return CategoriesResponse.fromJson(jsonResponse);
  }

  Future<CategoryDetailsResponse> fetchCategoryDetails(
    String token,
    int id,
  ) async {
    dynamic jsonResponse = await http.get(
      url: '$baseUrl/api/categories/$id',
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );

    return CategoryDetailsResponse.fromJson(jsonResponse);
  }

  Future<DeleteCategoryResponse> deleteCategory(String token, int id) async {
    dynamic jsonResponse = await http.delete(
      url: '$baseUrl/api/categories/$id',
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );

    return DeleteCategoryResponse.fromJson(jsonResponse);
  }
}
