import 'package:expense_tracker/data/models/expense_model.dart';

class DashboardSummary {
  num thisMonthExpenses;
  num lastMonthExpenses;
  String? aiInsights;

  DashboardSummary({
    required this.thisMonthExpenses,
    required this.lastMonthExpenses,
    this.aiInsights,
  });

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      thisMonthExpenses: json['this_month_expenses'],
      lastMonthExpenses: json['last_month_expenses'],
      aiInsights: json['ai_insights'],
    );
  }
}

class ExpensesByCategory {
  String name;
  num amount;

  ExpensesByCategory({required this.name, required this.amount});

  factory ExpensesByCategory.fromJson(Map<String, dynamic> json) {
    return ExpensesByCategory(name: json['name'], amount: json['amount']);
  }
}

class DashboardLists {
  List<Expense> recentExpenses;
  List<ExpensesByCategory> expensesByCategory;

  DashboardLists({
    required this.recentExpenses,
    required this.expensesByCategory,
  });

  factory DashboardLists.fromJson(Map<String, dynamic> json) {
    return DashboardLists(
      recentExpenses: List<Expense>.from(
        json['recent_expenses'].map((model) => Expense.fromJson(model)),
      ),
      expensesByCategory: List<ExpensesByCategory>.from(
        json['expenses_by_category'].map(
          (model) => ExpensesByCategory.fromJson(model),
        ),
      ),
    );
  }
}

class DashboardResponseData {
  DashboardSummary summary;
  DashboardLists lists;

  DashboardResponseData({required this.summary, required this.lists});

  factory DashboardResponseData.fromJson(Map<String, dynamic> json) {
    return DashboardResponseData(
      summary: DashboardSummary.fromJson(json['summary']),
      lists: DashboardLists.fromJson(json['lists']),
    );
  }
}

class DashboardResponse {
  String message;
  DashboardResponseData data;

  DashboardResponse({required this.message, required this.data});

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      message: json['message'],
      data: DashboardResponseData.fromJson(json['data']),
    );
  }
}
