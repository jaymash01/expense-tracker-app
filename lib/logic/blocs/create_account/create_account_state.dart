import 'package:equatable/equatable.dart';

class CreateAccountState extends Equatable {
  final String name;
  final String email;
  final String password;
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  const CreateAccountState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  CreateAccountState copyWith({
    String? name,
    String? email,
    String? password,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return CreateAccountState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    isLoading,
    isSuccess,
    error,
  ];
}
