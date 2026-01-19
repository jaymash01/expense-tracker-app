import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/logic/blocs/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDropdown extends StatelessWidget {
  final String? value;
  final List<Map<String, String>> items;
  final Function(String?) onChanged;
  final String? hint;

  const AppDropdown({
    super.key,
    this.value,
    required this.items,
    required this.onChanged,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeBloc>().state.isDarkMode;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: isDarkMode
            ? Border.all(color: context.colorScheme.outline, width: 1.0)
            : null,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: hint != null
              ? Text(
                  hint!,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.textTheme.bodySmall!.color!,
                  ),
                )
              : null,
          icon: Icon(Icons.arrow_drop_down_rounded),
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item['value'],
                  child: Text(
                    item['label']!,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
