import 'package:expense_tracker/data/models/category_model.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/presentation/screens/auth/create_account_screen.dart';
import 'package:expense_tracker/presentation/screens/auth/login_screen.dart';
import 'package:expense_tracker/presentation/screens/auth/splash_screen.dart';
import 'package:expense_tracker/presentation/screens/categories/categories_screen.dart';
import 'package:expense_tracker/presentation/screens/categories/create_category_screen.dart';
import 'package:expense_tracker/presentation/screens/categories/update_category_screen.dart';
import 'package:expense_tracker/presentation/screens/expenses/create_expense_screen.dart';
import 'package:expense_tracker/presentation/screens/expenses/expenses_screen.dart';
import 'package:expense_tracker/presentation/screens/expenses/update_expense_screen.dart';
import 'package:expense_tracker/presentation/screens/home/home_navigation_bar.dart';
import 'package:expense_tracker/presentation/screens/settings/change_password_screen.dart';
import 'package:expense_tracker/presentation/screens/settings/update_account_screen.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case AppRoutes.createAccount:
        return MaterialPageRoute(
          builder: (_) => const CreateAccountScreen(),
          settings: settings,
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => HomeNavigationBar(),
          settings: settings,
        );

      case AppRoutes.updateAccount:
        return MaterialPageRoute(
          builder: (_) => UpdateAccountScreen(),
          settings: settings,
        );

      case AppRoutes.changePassword:
        return MaterialPageRoute(
          builder: (_) => ChangePasswordScreen(),
          settings: settings,
        );

      case AppRoutes.createCategory:
        return MaterialPageRoute(
          builder: (_) => CreateCategoryScreen(),
          settings: settings,
        );

      case AppRoutes.categories:
        return MaterialPageRoute(
          builder: (_) => CategoriesScreen(),
          settings: settings,
        );

      case AppRoutes.updateCategory:
        final args = settings.arguments as Category;
        return MaterialPageRoute(
          builder: (_) => UpdateCategoryScreen(category: args),
          settings: settings,
        );

      case AppRoutes.createExpense:
        return MaterialPageRoute(
          builder: (_) => CreateExpenseScreen(),
          settings: settings,
        );

      case AppRoutes.expenses:
        return MaterialPageRoute(
          builder: (_) => ExpensesScreen(),
          settings: settings,
        );

      case AppRoutes.updateExpense:
        final args = settings.arguments as Expense;
        return MaterialPageRoute(
          builder: (_) => UpdateExpenseScreen(expense: args),
          settings: settings,
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('404 - Page not found'))),
    );
  }
}
