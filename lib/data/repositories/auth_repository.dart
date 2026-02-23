import 'dart:async';

import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/core/network/dio_client.dart' as dio;
import 'package:expense_tracker/data/models/auth_model.dart';
import 'package:expense_tracker/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<CreateAccountResponse> createAccount(Map<String, dynamic> body) async {
    dynamic jsonResponse = await dio.post(
      url: '/api/auth/create-account',
      body: body,
    );

    return CreateAccountResponse.fromJson(jsonResponse);
  }

  Future<LoginResponse> login(Map<String, dynamic> body) async {
    dynamic jsonResponse = await dio.post(url: '/api/auth/login', body: body);

    return LoginResponse.fromJson(jsonResponse);
  }

  Future<UpdateAccountResponse> updateAccount(
    String? photoUrl,
    Map<String, dynamic> body,
  ) async {
    dynamic jsonResponse;

    if (photoUrl != null) {
      jsonResponse = await dio.postMultipart(
        url: '/api/auth/update-account',
        fileField: 'photo',
        filePath: photoUrl,
        otherFields: body,
      );
    } else {
      jsonResponse = await dio.post(
        url: '/api/auth/update-account',
        body: body,
      );
    }

    return UpdateAccountResponse.fromJson(jsonResponse);
  }

  Future<User> fetchUserDetails() async {
    dynamic jsonResponse = await dio.get(url: '/api/auth/user');

    return User.fromJson(jsonResponse['data']);
  }

  Future<ChangePasswordResponse> changePassword(
    Map<String, dynamic> body,
  ) async {
    dynamic jsonResponse = await dio.post(
      url: '/api/auth/change-password',
      body: body,
    );

    return ChangePasswordResponse.fromJson(jsonResponse);
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: Preferences.accessToken);
  }

  Future<void> setAccessToken(String value) async {
    return _storage.write(key: Preferences.accessToken, value: value);
  }

  Future<void> logout() async {
    await _storage.delete(key: Preferences.accessToken);
  }
}
