import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:expense_tracker/logic/blocs/login/login_event.dart';
import 'package:expense_tracker/logic/blocs/login/login_bloc.dart';
import 'package:expense_tracker/logic/blocs/login/login_state.dart';
import 'package:expense_tracker/presentation/navigation/app_routes.dart';
import 'package:expense_tracker/presentation/widgets/loading_button.dart';
import 'package:expense_tracker/presentation/widgets/app_alert.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(authBloc: context.read<AuthBloc>()),
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (BuildContext context, LoginState state) {
            if (state.isSuccess) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            } else if (state.error != null) {
              appAlert(context, state.error!, type: AlertType.error);
            }
          },
          builder: (BuildContext context, LoginState state) {
            final bloc = context.read<LoginBloc>();

            return ScreenSafeArea(
              includeTop: true,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppDimensions.spaceXL),
                child: Column(
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.8,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 96.0,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            SizedBox(height: AppDimensions.spaceXL),
                            Text(
                              'Welcome',
                              style: context.textTheme.titleLarge!.copyWith(
                                color: context.colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: AppDimensions.spaceXS),
                            Text(
                              'Sign in to track your expenses',
                              style: context.textTheme.titleSmall!.merge(
                                TextStyle(
                                  color: context.textTheme.labelSmall!.color,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: AppDimensions.spaceXL),
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                prefixIcon: Icon(Icons.alternate_email_rounded),
                              ),
                              onChanged: (String value) {
                                BlocProvider.of<LoginBloc>(
                                  context,
                                ).add(LoginUsernameChanged(value));
                              },
                            ),
                            SizedBox(height: AppDimensions.spaceL),
                            TextField(
                              obscureText: !_showPassword,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: const Icon(Icons.lock_rounded),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  icon: Icon(
                                    _showPassword
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                  ),
                                ),
                              ),
                              onChanged: (String value) {
                                BlocProvider.of<LoginBloc>(
                                  context,
                                ).add(LoginPasswordChanged(value));
                              },
                            ),
                            SizedBox(height: AppDimensions.spaceXL),
                            LoadingButton(
                              loading: state.isLoading,
                              child: const Text('Login'),
                              onPressed: () {
                                if (_validateForm(state)) {
                                  bloc.add(LoginSubmitted());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    SizedBox(height: AppDimensions.spaceS),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.createAccount,
                          ),
                          child: Text(
                            'Sign up',
                            style: context.textTheme.titleSmall!.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.spaceM),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _validateForm(LoginState state) {
    if (state.username.isEmpty || state.password.isEmpty) {
      appAlert(context, 'Please fill all the fields', type: AlertType.error);
      return false;
    }

    return true;
  }
}
