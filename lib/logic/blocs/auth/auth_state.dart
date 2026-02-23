import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/user_model.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool isAuthenticated;
  final User? user;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
  });

  AuthState copyWith({bool? isLoading, bool? isAuthenticated, User? user}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [isLoading, isAuthenticated, user];
}
