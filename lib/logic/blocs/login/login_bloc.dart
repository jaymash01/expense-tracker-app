import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/data/repositories/auth_repository.dart';
import 'package:expense_tracker/core/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_event.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository = AuthRepository();
  final AuthBloc authBloc;

  LoginBloc({required this.authBloc}) : super(const LoginState()) {
    on<LoginUsernameChanged>((event, emit) {
      emit(state.copyWith(username: event.username, error: null));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, error: null));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));

      try {
        final response = await authRepository.login(<String, dynamic>{
          'email': state.username,
          'password': state.password,
        });

        final storage = FlutterSecureStorage();
        final token = response.data!.token;

        await storage.write(key: Preferences.token, value: token);

        authBloc.add(AuthLoggedIn(token));
        authBloc.add(AuthUserFetched(token));

        emit(state.copyWith(isLoading: false, isSuccess: true));
      } catch (e) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            error: e.toString(),
          ),
        );
      }
    });
  }
}
