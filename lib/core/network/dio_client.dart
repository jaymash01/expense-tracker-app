import 'package:dio/dio.dart';
import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/core/exceptions/app_exception.dart';
import 'package:expense_tracker/core/network/auth_interceptor.dart';

// Initialize Dio with default options
final Dio _dio =
    Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {'Content-Type': 'application/json'},
        ),
      )
      ..interceptors.addAll([
        AuthInterceptor(),
        LogInterceptor(responseBody: true, requestBody: true),
      ]);

Future<dynamic> get({
  required String url,
  Map<String, dynamic>? headers,
  Map<String, dynamic>? params,
}) async {
  try {
    final response = await _dio.get(
      url,
      queryParameters: params,
      options: Options(headers: headers),
    );
    return response.data;
  } on DioException catch (e) {
    throw _handleError(e);
  }
}

Future<dynamic> post({
  required String url,
  Map<String, dynamic>? headers,
  Map<String, dynamic>? body,
}) async {
  try {
    final response = await _dio.post(
      url,
      data: body,
      options: Options(headers: headers),
    );
    return response.data;
  } on DioException catch (e) {
    throw _handleError(e);
  }
}

Future<dynamic> postMultipart({
  required String url,
  required String fileField,
  required String filePath,
  Map<String, dynamic>? headers,
  Map<String, dynamic>? otherFields,
}) async {
  try {
    // Create FormData for multipart requests
    final formData = FormData.fromMap({
      ...otherFields ?? {},
      fileField: await MultipartFile.fromFile(filePath),
    });

    final response = await _dio.post(
      url,
      data: formData,
      options: Options(headers: headers),
    );
    return response.data;
  } on DioException catch (e) {
    throw _handleError(e);
  }
}

Future<dynamic> put({
  required String url,
  Map<String, dynamic>? headers,
  Map<String, dynamic>? body,
}) async {
  try {
    final response = await _dio.put(
      url,
      data: body,
      options: Options(headers: headers),
    );
    return response.data;
  } on DioException catch (e) {
    throw _handleError(e);
  }
}

Future<dynamic> patch({
  required String url,
  Map<String, dynamic>? headers,
  Map<String, dynamic>? body,
}) async {
  try {
    final response = await _dio.patch(
      url,
      data: body,
      options: Options(headers: headers),
    );
    return response.data;
  } on DioException catch (e) {
    throw _handleError(e);
  }
}

Future<dynamic> delete({
  required String url,
  Map<String, dynamic>? headers,
  Map<String, dynamic>? body,
}) async {
  try {
    final response = await _dio.delete(
      url,
      data: body,
      options: Options(headers: headers),
    );
    return response.data;
  } on DioException catch (e) {
    throw _handleError(e);
  }
}

/// Centralized Error Handling for Dio
AppException _handleError(DioException e) {
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return const AppException('Connection timed out');
  }

  if (e.type == DioExceptionType.connectionError) {
    return const AppException('Connection failed');
  }

  if (e.response != null) {
    final message = e.response?.data?['message'] ?? 'Something went wrong';
    return AppException(message);
  }

  return const AppException('Something went wrong');
}
