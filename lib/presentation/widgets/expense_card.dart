import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/core/utils/helpers.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/logic/blocs/theme/theme_bloc.dart';
import 'package:expense_tracker/presentation/widgets/outlined_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback? onTap;

  const ExpenseCard({super.key, required this.expense, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeBloc>().state.isDarkMode;

    return OutlinedCard(
      margin: EdgeInsets.only(bottom: AppDimensions.spaceM),
      elevation: AppDimensions.elevationNone,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.spaceM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'TZS ${numberFormat(expense.amount)}',
                          style: isDarkMode
                              ? context.textTheme.titleMedium
                              : context.textTheme.titleMedium!.copyWith(
                                  color: context.colorScheme.primary,
                                ),
                        ),
                        SizedBox(height: AppDimensions.spaceXS),
                        Text(
                          niceDate(expense.expenseDate),
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if ((expense.description ?? '').isNotEmpty)
                SizedBox(height: AppDimensions.spaceS),
              if ((expense.description ?? '').isNotEmpty)
                Text(expense.description!, style: context.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
