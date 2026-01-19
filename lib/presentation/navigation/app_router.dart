import 'package:expense_tracker/presentation/screens/auth/create_account_screen.dart';
import 'package:expense_tracker/presentation/screens/auth/login_screen.dart';
import 'package:expense_tracker/presentation/screens/auth/splash_screen.dart';
import 'package:expense_tracker/presentation/screens/create_expense/create_expense_screen.dart';
import 'package:expense_tracker/presentation/screens/expenses/expenses_screen.dart';
import 'package:expense_tracker/presentation/screens/home/home_navigation_bar.dart';
import 'package:expense_tracker/presentation/screens/settings/change_password_screen.dart';
import 'package:expense_tracker/presentation/screens/settings/edit_account_screen.dart';
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
          builder: (_) => EditAccountScreen(),
          settings: settings,
        );

      case AppRoutes.changePassword:
        return MaterialPageRoute(
          builder: (_) => ChangePasswordScreen(),
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
