import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/logic/blocs/theme/theme_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalDescription extends StatelessWidget {
  final Widget? icon;
  final String label;
  final String? value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const HorizontalDescription({
    super.key,
    this.icon,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeBloc>().state.isDarkMode;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Row(
            children: <Widget>[
              if (icon != null) icon!,
              if (icon != null) SizedBox(width: AppDimensions.spaceS),
              Text(
                label,
                style: context.textTheme.titleSmall!.merge(labelStyle),
              ),
            ],
          ),
        ),
        SizedBox(width: AppDimensions.spaceM),
        Expanded(
          flex: 3,
          child: Text(
            value ?? '',
            style: !isDarkMode
                ? context.textTheme.bodyMedium!
                      .copyWith(color: context.colorScheme.primary)
                      .merge(valueStyle)
                : context.textTheme.bodyMedium!
                      .copyWith(color: context.textTheme.bodySmall!.color)
                      .merge(valueStyle),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
