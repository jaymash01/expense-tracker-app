import 'package:expense_tracker/data/models/category_model.dart';

class CreateExpenseState {
  final Category? category;
  final String amount;
  final String? description;
  final String? expenseDate;
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  CreateExpenseState({
    this.category,
    this.amount = '',
    this.description,
    this.expenseDate,
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  CreateExpenseState copyWith({
    Category? category,
    String? amount,
    String? description,
    String? expenseDate,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return CreateExpenseState(
      category: category ?? this.category,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      expenseDate: expenseDate ?? this.expenseDate,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }
}
