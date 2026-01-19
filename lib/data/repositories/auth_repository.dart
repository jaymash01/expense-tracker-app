import 'dart:async';

import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/core/utils/http.dart' as http;
import 'package:expense_tracker/data/models/auth_model.dart';
import 'package:expense_tracker/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  Future<CreateAccountResponse> createAccount(Map<String, dynamic> body) async {
    dynamic jsonResponse = await http.post(
      url: '$baseUrl/api/auth/create-account',
      body: body,
    );

    return CreateAccountResponse.fromJson(jsonResponse);
  }

  Future<LoginResponse> login(Map<String, dynamic> body) async {
    dynamic jsonResponse = await http.post(
      url: '$baseUrl/api/auth/login',
      body: body,
    );

    return LoginResponse.fromJson(jsonResponse);
  }

  Future<UpdateAccountResponse> updateAccount(
    String token,
    String? photoUrl,
    Map<String, dynamic> body,
  ) async {
    dynamic jsonResponse;

    if (photoUrl != null) {
      jsonResponse = await http.postMultipart(
        url: '$baseUrl/api/auth/update-account',
        fileField: 'photo',
        filePath: photoUrl,
        otherFields: body,
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );
    } else {
      jsonResponse = await http.post(
        url: '$baseUrl/api/auth/update-account',
        body: body,
        headers: <String, String>{'Authorization': 'Bearer $token'},
      );
    }

    return UpdateAccountResponse.fromJson(jsonResponse);
  }

  Future<User> fetchUserDetails(String token) async {
    dynamic jsonResponse = await http.get(
      url: '$baseUrl/api/auth/user',
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );

    return User.fromJson(jsonResponse['data']);
  }

  Future<ChangePasswordResponse> changePassword(
    String token,
    Map<String, dynamic> body,
  ) async {
    dynamic jsonResponse = await http.post(
      url: '$baseUrl/api/auth/change-password',
      body: body,
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );

    return ChangePasswordResponse.fromJson(jsonResponse);
  }

  Future<String?> getToken() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: Preferences.token);
  }

  Future<void> logout() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: Preferences.token);
  }
}
