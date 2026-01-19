import 'package:expense_tracker/data/models/user_model.dart';

class CreateAccountResponseData {
  User user;
  String token;

  CreateAccountResponseData({required this.user, required this.token});

  factory CreateAccountResponseData.fromJson(Map<String, dynamic> json) {
    return CreateAccountResponseData(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}

class CreateAccountResponse {
  String message;
  CreateAccountResponseData? data;

  CreateAccountResponse({required this.message, required this.data});

  factory CreateAccountResponse.fromJson(Map<String, dynamic> json) {
    return CreateAccountResponse(
      message: json['message'],
      data: json['data'] != null
          ? CreateAccountResponseData.fromJson(json['data'])
          : null,
    );
  }
}

class LoginResponseData {
  User user;
  String token;

  LoginResponseData({required this.user, required this.token});

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}

class LoginResponse {
  String message;
  LoginResponseData? data;

  LoginResponse({required this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      data: json['data'] != null
          ? LoginResponseData.fromJson(json['data'])
          : null,
    );
  }
}

class UpdateAccountResponse {
  String message;
  User? data;

  UpdateAccountResponse({required this.message, this.data});

  factory UpdateAccountResponse.fromJson(Map<String, dynamic> json) {
    return UpdateAccountResponse(
      message: json['message'],
      data: json['data'] != null ? User.fromJson(json['data']) : null,
    );
  }
}

class ChangePasswordResponse {
  String message;

  ChangePasswordResponse({required this.message});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(message: json['message']);
  }
}
