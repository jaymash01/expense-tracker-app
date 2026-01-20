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
  final Widget? suffixIcon;

  const AppDropdown({
    super.key,
    this.value,
    required this.items,
    required this.onChanged,
    this.hint,
    this.suffixIcon,
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
            ? Border.all(color: context.colorScheme.outline, width: 0.5)
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
          icon: Row(
            children: <Widget>[
              if (suffixIcon != null) suffixIcon!,
              Icon(Icons.arrow_drop_down),
            ],
          ),
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
