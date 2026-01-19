import 'package:expense_tracker/core/config/constants.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/data/repositories/auth_repository.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'create_account_event.dart';
import 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  final AuthRepository authRepository = AuthRepository();
  final AuthBloc authBloc;

  CreateAccountBloc({required this.authBloc})
    : super(const CreateAccountState()) {
    on<CreateAccountNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name, error: null));
    });

    on<CreateAccountEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, error: null));
    });

    on<CreateAccountPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, error: null));
    });

    on<CreateAccountSubmitted>(_onCreateAccountSubmitted);

    on<CreateAccountReset>((event, emit) {
      emit(CreateAccountState());
    });
  }

  Future<void> _onCreateAccountSubmitted(
    CreateAccountSubmitted event,
    Emitter<CreateAccountState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, error: null));

    try {
      final response = await authRepository.createAccount(<String, dynamic>{
        'name': state.name,
        'email': state.email,
        'password': state.password,
      });

      final token = response.data!.token;
      final storage = FlutterSecureStorage();

      await storage.write(key: Preferences.token, value: token);

      authBloc.add(AuthLoggedIn(token));
      authBloc.add(AuthUserFetched(token));

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
