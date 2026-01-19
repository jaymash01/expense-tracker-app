import 'package:equatable/equatable.dart';

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
