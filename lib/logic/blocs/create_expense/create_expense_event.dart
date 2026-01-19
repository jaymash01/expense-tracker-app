import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/category_model.dart';

abstract class CreateExpenseEvent extends Equatable {
  const CreateExpenseEvent();

  @override
  List<Object?> get props => [];
}

class CreateExpenseCategoryChanged extends CreateExpenseEvent {
  final Category? category;

  const CreateExpenseCategoryChanged(this.category);

  @override
  List<Object?> get props => [category];
}

class CreateExpenseAmountChanged extends CreateExpenseEvent {
  final String amount;

  const CreateExpenseAmountChanged(this.amount);

  @override
  List<Object?> get props => [amount];
}

class CreateExpenseDescriptionChanged extends CreateExpenseEvent {
  final String? description;

  const CreateExpenseDescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class CreateExpenseDateChanged extends CreateExpenseEvent {
  final String expenseDate;

  const CreateExpenseDateChanged(this.expenseDate);

  @override
  List<Object?> get props => [expenseDate];
}

class CreateExpenseSubmitted extends CreateExpenseEvent {}

class CreateExpenseReset extends CreateExpenseEvent {}
