import 'dart:math';

import 'package:expense_tracker/data/models/expense_model.dart';

class ExpensesState {
  final List<Expense> expenses;
  final bool isLoading;
  final int currentPage;
  final bool isLastPage;

  ExpensesState({
    required this.expenses,
    this.isLoading = false,
    this.currentPage = 1,
    this.isLastPage = false,
  });

  ExpensesState copyWith({
    List<Expense>? expenses,
    bool? isLoading,
    int? currentPage,
    bool? isLastPage,
  }) {
    return ExpensesState(
      expenses: expenses ?? this.expenses,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }
}
