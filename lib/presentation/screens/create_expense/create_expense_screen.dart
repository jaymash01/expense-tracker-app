import 'package:expense_tracker/logic/blocs/auth/auth_bloc.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_bloc.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_event.dart';
import 'package:expense_tracker/logic/blocs/create_expense/create_expense_bloc.dart';
import 'package:expense_tracker/logic/blocs/create_expense/create_expense_state.dart';
import 'package:expense_tracker/presentation/navigation/app_routes.dart';
import 'package:expense_tracker/presentation/widgets/app_alert.dart';
import 'package:expense_tracker/presentation/widgets/screen_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateExpenseScreen extends StatefulWidget {
  const CreateExpenseScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateExpenseScreenState();
}

class _CreateExpenseScreenState extends State<CreateExpenseScreen> {
  @override
  void initState() {
    super.initState();

    context.read<CategoriesBloc>().add(LoadCategories(null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreateExpenseBloc(authBloc: context.read<AuthBloc>()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text('Create Expense'),
        ),
        body: BlocConsumer<CreateExpenseBloc, CreateExpenseState>(
          listener: (BuildContext context, CreateExpenseState state) {
            if (state.isSuccess) {
              appAlert(context, 'Expense created', type: AlertType.success);
              Navigator.pushNamed(context, AppRoutes.expenses);
            } else if (state.error != null) {
              appAlert(context, state.error!, type: AlertType.error);
            }
          },
          builder: (BuildContext context, CreateExpenseState state) {
            return ScreenSafeArea(child: Column());
          },
        ),
      ),
    );
  }
}
