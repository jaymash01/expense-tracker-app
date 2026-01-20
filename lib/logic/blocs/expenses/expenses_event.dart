import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/expense_model.dart';

class ExpensesEvent extends Equatable {
  const ExpensesEvent();

  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpensesEvent {
  final Map<String, dynamic>? params;

  const LoadExpenses(this.params);

  @override
  List<Object?> get props => [params];
}

class LoadMoreExpenses extends ExpensesEvent {
  final Map<String, dynamic>? params;

  const LoadMoreExpenses(this.params);

  @override
  List<Object?> get props => [params];
}

class DeleteExpense extends ExpensesEvent {
  final Expense expense;

  const DeleteExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}
