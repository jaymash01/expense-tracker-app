import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/core/utils/helpers.dart';
import 'package:expense_tracker/data/models/dashboard_model.dart';
import 'package:expense_tracker/presentation/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class ExpensesByCategoryCard extends StatelessWidget {
  final ExpensesByCategory category;
  final num totalAmount;
  final int index;

  const ExpensesByCategoryCard({
    super.key,
    required this.category,
    required this.totalAmount,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      context.colorScheme.primary,
      Colors.teal,
      Colors.orange,
      Colors.pink,
    ];

    return Card(
      margin: EdgeInsets.only(bottom: AppDimensions.spaceM),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox.square(
                  dimension: 40.0,
                  child: Card(
                    color: context.colorScheme.primary,
                    child: Center(
                      child: Text(
                        category.name.trimLeft().characters.first.toUpperCase(),
                        style: TextStyle(
                          color: context.colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppDimensions.spaceM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'TZS ${numberFormat(category.amount)}',
                        style: context.textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: AppDimensions.spaceS),
                      Text(category.name, style: context.textTheme.bodySmall),
                    ],
                  ),
                ),
                SizedBox(height: AppDimensions.spaceM),
                SizedBox(
                  width: 80.0,
                  child: ProgressBar(
                    value: _getCategoryProgress(),
                    height: 12.0,
                    color: colors[index % colors.length],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _getCategoryProgress() {
    double value = (category.amount / (totalAmount)) * 1.0;
    return value >= 1.0 ? 1.0 : value;
  }
}
