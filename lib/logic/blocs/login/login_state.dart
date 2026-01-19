import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  const LoginState({
    this.username = '',
    this.password = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  LoginState copyWith({
    String? username,
    String? password,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  @override
  List<Object?> get props => [username, password, isLoading, isSuccess, error];
}
