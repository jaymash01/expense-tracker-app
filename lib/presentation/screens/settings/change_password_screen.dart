import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/data/repositories/auth_repository.dart';
import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:expense_tracker/presentation/widgets/app_alert.dart';
import 'package:expense_tracker/presentation/widgets/form_label_control.dart';
import 'package:expense_tracker/presentation/widgets/loading_button.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final AuthRepository _authRepository = AuthRepository();

  Map<String, dynamic> _formData = <String, dynamic>{};
  bool _showPassword = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text('Change Password'),
      ),
      body: ScreenSafeArea(
        includeTop: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceM,
            vertical: AppDimensions.spaceXL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FormLabelControl(
                label: 'Current Password',
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
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                      ),
                    ),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _formData['current_password'] = value;
                    });
                  },
                ),
              ),
              SizedBox(height: AppDimensions.spaceM),
              FormLabelControl(
                label: 'New Password',
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
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                      ),
                    ),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _formData['new_password'] = value;
                    });
                  },
                ),
              ),
              SizedBox(height: AppDimensions.spaceXL),
              LoadingButton(
                loading: _isLoading,
                child: const Text('Submit'),
                onPressed: () {
                  if (_validateForm()) {
                    submit();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    if ((_formData['current_password'] ?? '').isEmpty ||
        (_formData['new_password'] ?? '').isEmpty) {
      appAlert(
        context,
        'Please fill all the required fields',
        type: AlertType.error,
      );
      return false;
    }

    return true;
  }

  void submit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final token = context.read<AuthBloc>().state.token ?? '';
      final body = _formData;

      final response = await _authRepository.changePassword(token, body);

      setState(() {
        _isLoading = true;
      });

      appAlert(
        context,
        response.message,
        type: AlertType.success,
        duration: const Duration(seconds: 10),
      );

      appAlert(context, response.message, type: AlertType.success);
      Navigator.pop(context);
    } catch (e) {
      appAlert(context, e.toString(), type: AlertType.error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
