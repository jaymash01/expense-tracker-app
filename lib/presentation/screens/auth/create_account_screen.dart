import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:expense_tracker/logic/blocs/create_account/create_account_bloc.dart';
import 'package:expense_tracker/logic/blocs/create_account/create_account_event.dart';
import 'package:expense_tracker/logic/blocs/create_account/create_account_state.dart';
import 'package:expense_tracker/presentation/navigation/app_routes.dart';
import 'package:expense_tracker/presentation/widgets/form_label_control.dart';
import 'package:expense_tracker/presentation/widgets/loading_button.dart';
import 'package:expense_tracker/presentation/widgets/app_alert.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreateAccountBloc(authBloc: context.read<AuthBloc>()),
      child: Scaffold(
        body: BlocConsumer<CreateAccountBloc, CreateAccountState>(
          listener: (BuildContext context, CreateAccountState state) {
            if (state.isSuccess) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            } else if (state.error != null) {
              appAlert(context, state.error!, type: AlertType.error);
            }
          },
          builder: (BuildContext context, CreateAccountState state) {
            final bloc = context.read<CreateAccountBloc>();

            return ScreenSafeArea(
              includeTop: true,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppDimensions.spaceXL),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.75,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                          'Sign up to track your expenses',
                          style: context.textTheme.titleSmall!.merge(
                            TextStyle(
                              color: context.textTheme.labelSmall!.color,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: AppDimensions.spaceXL),
                        FormLabelControl(
                          label: 'Full Name',
                          child: TextField(
                            keyboardType: TextInputType.name,
                            onChanged: (String value) {
                              BlocProvider.of<CreateAccountBloc>(
                                context,
                              ).add(CreateAccountNameChanged(value));
                            },
                          ),
                        ),
                        SizedBox(height: AppDimensions.spaceM),
                        FormLabelControl(
                          label: 'Email',
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (String value) {
                              BlocProvider.of<CreateAccountBloc>(
                                context,
                              ).add(CreateAccountEmailChanged(value));
                            },
                          ),
                        ),
                        SizedBox(height: AppDimensions.spaceM),
                        FormLabelControl(
                          label: 'Password',
                          child: TextField(
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                icon: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            onChanged: (String value) {
                              BlocProvider.of<CreateAccountBloc>(
                                context,
                              ).add(CreateAccountPasswordChanged(value));
                            },
                          ),
                        ),
                        SizedBox(height: AppDimensions.spaceXL),
                        LoadingButton(
                          loading: state.isLoading,
                          child: const Text('Submit'),
                          onPressed: () {
                            if (_validateForm(state)) {
                              bloc.add(CreateAccountSubmitted());
                            }
                          },
                        ),
                        SizedBox(height: AppDimensions.spaceXL),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Already have an account? "),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.login,
                              ),
                              child: Text(
                                'Login',
                                style: context.textTheme.titleSmall!.copyWith(
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _validateForm(CreateAccountState state) {
    if (state.name.isEmpty || state.email.isEmpty || state.password.isEmpty) {
      appAlert(
        context,
        'Please fill all the required fields',
        type: AlertType.error,
      );
      return false;
    }

    return true;
  }
}
