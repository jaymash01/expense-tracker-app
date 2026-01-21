import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/core/utils/helpers.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/logic/blocs/dashboard/dashboard_bloc.dart';
import 'package:expense_tracker/logic/blocs/dashboard/dashboard_event.dart';
import 'package:expense_tracker/logic/blocs/expenses/expenses_bloc.dart';
import 'package:expense_tracker/logic/blocs/expenses/expenses_event.dart';
import 'package:expense_tracker/logic/blocs/theme/theme_bloc.dart';
import 'package:expense_tracker/presentation/navigation/app_routes.dart';
import 'package:expense_tracker/presentation/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final bool showDescription;
  final bool showActions;

  const ExpenseCard({
    super.key,
    required this.expense,
    this.showDescription = true,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeBloc>().state.isDarkMode;

    return Card(
      margin: EdgeInsets.only(bottom: AppDimensions.spaceM),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'TZS ${numberFormat(expense.amount)}',
                    style: isDarkMode
                        ? context.textTheme.titleMedium
                        : context.textTheme.titleMedium!.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                  ),
                ),
                SizedBox(height: AppDimensions.spaceM),
                Text(
                  niceDate(expense.expenseDate),
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
            SizedBox(height: AppDimensions.spaceS),
            Row(
              children: <Widget>[
                Icon(Icons.folder, size: AppDimensions.iconSizeXS),
                SizedBox(width: AppDimensions.spaceS),
                Text(
                  expense.category!.name,
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
            if (showDescription && (expense.description ?? '').isNotEmpty)
              SizedBox(height: AppDimensions.spaceM),
            if (showDescription && (expense.description ?? '').isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceS,
                  vertical: AppDimensions.spaceXS,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: context.colorScheme.outline,
                      width: 3.0,
                    ),
                  ),
                ),
                child: Text(
                  expense.description!,
                  style: context.textTheme.bodySmall!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            if (showActions) SizedBox(height: AppDimensions.spaceM),
            if (showActions)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox.square(
                    dimension: 32.0,
                    child: IconButton(
                      iconSize: AppDimensions.iconSizeXS,
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRoutes.updateExpense,
                        arguments: expense,
                      ),
                      icon: Icon(Icons.edit),
                      tooltip: 'Edit',
                    ),
                  ),
                  SizedBox.square(
                    dimension: 32.0,
                    child: IconButton(
                      iconSize: AppDimensions.iconSizeXS,
                      onPressed: () => _confirmDelete(context),
                      icon: Icon(Icons.delete),
                      tooltip: 'Delete',
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    Dialogs.showConfirmationDialog(
      context,
      'Delete Expense',
      'Are you sure you want to delete this expense?',
      () {
        Navigator.pop(context);
        context.read<ExpensesBloc>().add(
          DeleteExpense(expense, () {
            context.read<ExpensesBloc>().add(LoadExpenses(null));
            context.read<DashboardBloc>().add(LoadDashboard());
          }),
        );
      },
    );
  }
}
