import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:expense_tracker/core/exceptions/app_exception.dart';

Future<dynamic> get({
  required String url,
  Map<String, String>? headers,
  Map<String, dynamic>? params,
}) async {
  try {
    Uri uri = Uri.parse(url);
    if (params != null && params.isNotEmpty) {
      uri = uri.replace(queryParameters: params);
    }

    http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        ...?headers,
      },
    );

    dynamic jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonResponse;
    }

    throw HttpException(jsonResponse['message']);
  } on TimeoutException {
    throw const AppException('Connection timed out');
  } on SocketException {
    throw const AppException('Connection failed');
  } on HttpException catch (e) {
    throw AppException(e.message);
  } on Exception {
    throw const AppException('Something went wrong');
  }
}

Future<dynamic> post({
  required String url,
  Map<String, String>? headers,
  Map<String, dynamic>? body,
}) async {
  try {
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: body != null && body.isNotEmpty ? jsonEncode(body) : null,
    );

    dynamic jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonResponse;
    }

    throw HttpException(jsonResponse['message']);
  } on TimeoutException {
    throw const AppException('Connection timed out');
  } on SocketException {
    throw const AppException('Connection failed');
  } on HttpException catch (e) {
    throw AppException(e.message);
  } on Exception {
    throw const AppException('Something went wrong');
  }
}

Future<dynamic> postMultipart({
  required String url,
  required String fileField,
  required String filePath,
  Map<String, String>? headers,
  Map<String, dynamic>? otherFields,
}) async {
  try {
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    headers?.forEach((key, value) {
      request.headers[key] = value;
    });

    request.files.add(await http.MultipartFile.fromPath(fileField, filePath));

    otherFields?.forEach((key, value) {
      request.fields[key] = value;
    });

    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);

    dynamic jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonResponse;
    }

    throw HttpException(jsonResponse['message']);
  } on TimeoutException {
    throw const AppException('Connection timed out');
  } on SocketException {
    throw const AppException('Connection failed');
  } on HttpException catch (e) {
    throw AppException(e.message);
  } on Exception {
    throw const AppException('Something went wrong');
  }
}

Future<dynamic> put({
  required String url,
  Map<String, String>? headers,
  Map<String, dynamic>? body,
}) async {
  try {
    http.Response response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: body != null && body.isNotEmpty ? jsonEncode(body) : null,
    );

    dynamic jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonResponse;
    }

    throw HttpException(jsonResponse['message']);
  } on TimeoutException {
    throw const AppException('Connection timed out');
  } on SocketException {
    throw const AppException('Connection failed');
  } on HttpException catch (e) {
    throw AppException(e.message);
  } on Exception {
    throw const AppException('Something went wrong');
  }
}

Future<dynamic> patch({
  required String url,
  Map<String, String>? headers,
  Map<String, dynamic>? body,
}) async {
  try {
    http.Response response = await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: body != null && body.isNotEmpty ? jsonEncode(body) : null,
    );

    dynamic jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonResponse;
    }

    throw HttpException(jsonResponse['message']);
  } on TimeoutException {
    throw const AppException('Connection timed out');
  } on SocketException {
    throw const AppException('Connection failed');
  } on HttpException catch (e) {
    throw AppException(e.message);
  } on Exception catch (e) {
    throw const AppException('Something went wrong');
  }
}

Future<dynamic> delete({
  required String url,
  Map<String, String>? headers,
  Map<String, dynamic>? body,
}) async {
  try {
    http.Response response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: body != null && body.isNotEmpty ? jsonEncode(body) : null,
    );

    dynamic jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return jsonResponse;
    }

    throw HttpException(jsonResponse['message']);
  } on TimeoutException {
    throw const AppException('Connection timed out');
  } on SocketException {
    throw const AppException('Connection failed');
  } on HttpException catch (e) {
    throw AppException(e.message);
  } on Exception {
    throw const AppException('Something went wrong');
  }
}
