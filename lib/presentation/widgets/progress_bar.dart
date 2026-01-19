import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  final double? height;

  const ProgressBar({super.key, required this.value, this.height = 8});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          ),
        ),
        FractionallySizedBox(
          widthFactor: value,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: _getProgressColor(value, context),
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            ),
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(double progress, BuildContext context) {
    if (progress >= 0.75) {
      return context.appColors.success ?? Colors.green;
    } else if (progress >= 0.5) {
      return context.appColors.warning ?? Colors.orange;
    } else {
      return context.colorScheme.error;
    }
  }
}
