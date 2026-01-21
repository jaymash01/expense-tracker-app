import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/data/repositories/expenses_repository.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'expenses_event.dart';
import 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final int pageSize = 15;
  final ExpensesRepository expensesRepository = ExpensesRepository();
  final AuthBloc authBloc;

  ExpensesBloc({required this.authBloc}) : super(ExpensesState(expenses: [])) {
    on<LoadExpenses>(_onLoadExpenses);
    on<LoadMoreExpenses>(_onLoadMoreExpenses);
    on<DeleteExpense>(_onDeleteExpense);
  }

  Future<void> _onLoadExpenses(
    LoadExpenses event,
    Emitter<ExpensesState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          currentPage: 1,
          isLastPage: false,
          expenses: <Expense>[],
        ),
      );

      final token = authBloc.state.token ?? '';

      Map<String, dynamic> params = <String, dynamic>{
        'page': '1',
        'per_page': '$pageSize',
      };

      if (event.params != null) {
        params.addAll(event.params!);
      }

      ExpensesResponse response = await expensesRepository.fetchExpenses(
        token,
        params,
      );

      emit(
        state.copyWith(
          isLoading: false,
          currentPage: response.page,
          isLastPage: response.data.length < pageSize,
          expenses: response.data,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onLoadMoreExpenses(
    LoadMoreExpenses event,
    Emitter<ExpensesState> emit,
  ) async {
    if (state.isLoading || state.isLastPage) return;

    try {
      emit(state.copyWith(isLoading: true));

      final token = authBloc.state.token ?? '';

      Map<String, dynamic> params = <String, dynamic>{
        'page': '${state.currentPage + 1}',
        'per_page': '$pageSize',
      };

      if (event.params != null) {
        params.addAll(event.params!);
      }

      ExpensesResponse response = await expensesRepository.fetchExpenses(
        token,
        params,
      );
      List<Expense> expenses = state.expenses;
      expenses.addAll(response.data);

      emit(
        state.copyWith(
          isLoading: false,
          currentPage: response.page,
          isLastPage: response.data.length < pageSize,
          expenses: expenses,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onDeleteExpense(
    DeleteExpense event,
    Emitter<ExpensesState> emit,
  ) async {
    try {
      List<Expense> expenses = state.expenses;

      expenses.removeWhere((element) => element.id == event.expense.id);
      emit(state.copyWith(expenses: expenses));

      final token = authBloc.state.token ?? '';

      await expensesRepository.deleteExpense(token, event.expense.id);

      if (event.onSuccess != null) {
        event.onSuccess!();
      }
    } catch (e) {
      // Ignored
    }
  }
}
