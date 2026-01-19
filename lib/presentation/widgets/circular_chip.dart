import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CircularChip extends StatelessWidget {
  final String label;
  final Color? color;
  final bool outlined;

  const CircularChip({
    super.key,
    required this.label,
    this.color,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = context.colorScheme.secondary;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceS,
        vertical: AppDimensions.spaceXS,
      ),
      decoration: BoxDecoration(
        color: color != null
            ? color!.withAlpha(38)
            : defaultColor.withAlpha(38),
        border: outlined
            ? Border.all(width: 0.5, color: color ?? defaultColor)
            : null,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Text(
        label,
        style: context.textTheme.bodySmall!.copyWith(
          color: color ?? defaultColor,
        ),
      ),
    );
  }
}
