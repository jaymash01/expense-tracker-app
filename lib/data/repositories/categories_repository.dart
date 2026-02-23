import 'dart:async';

import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/core/network/dio_client.dart' as dio;
import 'package:expense_tracker/data/models/category_model.dart';

class CategoriesRepository {
  Future<CreateCategoryResponse> createCategory(
    Map<String, dynamic> body,
  ) async {
    dynamic jsonResponse = await dio.post(url: '/api/categories', body: body);

    return CreateCategoryResponse.fromJson(jsonResponse);
  }

  Future<CategoriesResponse> fetchCategories(
    Map<String, dynamic>? params,
  ) async {
    dynamic jsonResponse = await dio.get(
      url: '/api/categories',
      params: params,
    );

    return CategoriesResponse.fromJson(jsonResponse);
  }

  Future<CategoryDetailsResponse> fetchCategoryDetails(int id) async {
    dynamic jsonResponse = await dio.get(url: '/api/categories/$id');

    return CategoryDetailsResponse.fromJson(jsonResponse);
  }

  Future<UpdateCategoryResponse> updateCategory(
    int id,
    Map<String, dynamic> body,
  ) async {
    dynamic jsonResponse = await dio.patch(
      url: '/api/categories/$id',
      body: body,
    );

    return UpdateCategoryResponse.fromJson(jsonResponse);
  }

  Future<DeleteCategoryResponse> deleteCategory(int id) async {
    dynamic jsonResponse = await dio.delete(url: '/api/categories/$id');

    return DeleteCategoryResponse.fromJson(jsonResponse);
  }
}
