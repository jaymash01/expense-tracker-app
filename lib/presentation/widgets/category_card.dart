import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/data/models/category_model.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_bloc.dart';
import 'package:expense_tracker/logic/blocs/categories/categories_event.dart';
import 'package:expense_tracker/logic/blocs/dashboard/dashboard_bloc.dart';
import 'package:expense_tracker/logic/blocs/dashboard/dashboard_event.dart';
import 'package:expense_tracker/logic/blocs/expenses/expenses_bloc.dart';
import 'package:expense_tracker/logic/blocs/expenses/expenses_event.dart';
import 'package:expense_tracker/presentation/navigation/app_routes.dart';
import 'package:expense_tracker/presentation/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: AppDimensions.spaceM),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.folder, size: AppDimensions.iconSizeXS),
                SizedBox(width: AppDimensions.spaceS),
                Expanded(
                  child: Text(
                    category.name,
                    style: context.textTheme.titleSmall,
                  ),
                ),
                SizedBox(height: AppDimensions.spaceM),
                SizedBox.square(
                  dimension: 32.0,
                  child: IconButton(
                    iconSize: AppDimensions.iconSizeXS,
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.updateCategory,
                      arguments: category,
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
            if ((category.description ?? '').isNotEmpty)
              SizedBox(height: AppDimensions.spaceM),
            if ((category.description ?? '').isNotEmpty)
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
                  category.description!,
                  style: context.textTheme.bodySmall!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    Dialogs.showConfirmationDialog(
      context,
      'Delete Category',
      'Are you sure you want to delete this category?',
      () {
        Navigator.pop(context);
        context.read<CategoriesBloc>().add(
          DeleteCategory(category, () {
            context.read<ExpensesBloc>().add(LoadExpenses(null));
            context.read<DashboardBloc>().add(LoadDashboard());
          }),
        );
      },
    );
  }
}
