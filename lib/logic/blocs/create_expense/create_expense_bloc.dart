import 'package:expense_tracker/data/repositories/expenses_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';

import 'create_expense_event.dart';
import 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {
  final ExpensesRepository expensesRepository = ExpensesRepository();
  final AuthBloc authBloc;

  CreateExpenseBloc({required this.authBloc}) : super(CreateExpenseState()) {
    on<CreateExpenseCategoryChanged>((event, emit) {
      emit(state.copyWith(category: event.category, error: null));
    });

    on<CreateExpenseAmountChanged>((event, emit) {
      emit(state.copyWith(amount: event.amount, error: null));
    });

    on<CreateExpenseDescriptionChanged>((event, emit) {
      emit(state.copyWith(description: event.description, error: null));
    });

    on<CreateExpenseDateChanged>((event, emit) {
      emit(state.copyWith(expenseDate: event.expenseDate, error: null));
    });

    on<CreateExpenseSubmitted>(_onCreateExpenseSubmitted);

    on<CreateExpenseReset>((event, emit) {
      emit(CreateExpenseState());
    });
  }

  Future<void> _onCreateExpenseSubmitted(
    CreateExpenseSubmitted event,
    Emitter<CreateExpenseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final token = authBloc.state.token ?? '';
      final body = <String, dynamic>{
        'category_id': state.category?.id,
        'amount': state.amount,
        'description': state.description,
        'expense_date': state.expenseDate,
      };

      final response = await expensesRepository.createExpense(token, body);

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, isSuccess: false, error: e.toString()),
      );
    }
  }
}
