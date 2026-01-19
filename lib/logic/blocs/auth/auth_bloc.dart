import 'package:expense_tracker/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository();

  AuthBloc() : super(const AuthState()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoggedIn>(_onAuthLoggedIn);
    on<AuthUserFetched>(_onAuthUserFetched);
    on<AuthLoggedOut>(_onAuthLoggedOut);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final token = await authRepository.getToken();

      if (token != null) {
        emit(
          state.copyWith(isAuthenticated: true, token: token, isLoading: false),
        );

        add(AuthUserFetched(token));
      } else {
        emit(state.copyWith(isAuthenticated: false, isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isAuthenticated: false));
    }
  }

  void _onAuthLoggedIn(AuthLoggedIn event, Emitter<AuthState> emit) {
    emit(state.copyWith(isAuthenticated: true, token: event.token));
  }

  Future<void> _onAuthUserFetched(
    AuthUserFetched event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final token = event.token ?? state.token;

      if (token != null) {
        final user = await authRepository.fetchUserDetails(token);
        emit(
          state.copyWith(user: user, isAuthenticated: true, isLoading: false),
        );
      }
    } catch (e) {
      final error = e.toString();
      if (error == 'Unauthenticated') {
        add(AuthLoggedOut());
      } else {
        emit(state.copyWith(isLoading: false));
      }
    }
  }

  Future<void> _onAuthLoggedOut(
    AuthLoggedOut event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.logout();
    emit(const AuthState(isAuthenticated: false));
  }
}
