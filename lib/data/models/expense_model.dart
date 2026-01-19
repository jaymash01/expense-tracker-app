import 'package:expense_tracker/data/models/category_model.dart';

class Expense {
  int id;
  Category category;
  num amount;
  String? description;
  String expenseDate;
  String? createdAt;

  Expense({
    required this.id,
    required this.category,
    required this.amount,
    this.description,
    required this.expenseDate,
    this.createdAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      category: Category.fromJson(json['category']),
      amount: json['amount'],
      description: json['description'],
      expenseDate: json['expense_date'],
      createdAt: json['created_at'],
    );
  }
}

class CreateExpenseResponse {
  String message;
  Expense? data;

  CreateExpenseResponse({required this.message, this.data});

  factory CreateExpenseResponse.fromJson(Map<String, dynamic> json) {
    return CreateExpenseResponse(
      message: json['message'],
      data: json['data'] != null ? Expense.fromJson(json['data']) : null,
    );
  }
}

class ExpensesResponse {
  int total;
  int page;
  List<Expense> data = [];

  ExpensesResponse({
    required this.total,
    required this.page,
    required this.data,
  });

  factory ExpensesResponse.fromJson(Map<String, dynamic> json) {
    return ExpensesResponse(
      total: json['data']['total'],
      page: json['data']['current_page'],
      data: List<Expense>.from(
        json['data']['data'].map((model) => Expense.fromJson(model)),
      ),
    );
  }
}

class ExpenseDetailsResponse {
  String message;
  Expense? data;

  ExpenseDetailsResponse({required this.message, required this.data});

  factory ExpenseDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ExpenseDetailsResponse(
      message: json['message'],
      data: json['data'] != null ? Expense.fromJson(json['data']) : null,
    );
  }
}

class DeleteExpenseResponse {
  String message;
  Expense? data;

  DeleteExpenseResponse({required this.message, this.data});

  factory DeleteExpenseResponse.fromJson(Map<String, dynamic> json) {
    return DeleteExpenseResponse(
      message: json['message'],
      data: json['data'] != null ? Expense.fromJson(json['data']) : null,
    );
  }
}
