import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_state.dart';
import 'package:expense_tracker/presentation/screens/auth/login_screen.dart';
import 'package:expense_tracker/presentation/screens/home/home_navigation_bar.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.isLoading && state.user == null) {
          return Scaffold(
            body: ScreenSafeArea(
              includeTop: true,
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 160.0,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          );
        } else if (state.isAuthenticated) {
          return const HomeNavigationBar();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
