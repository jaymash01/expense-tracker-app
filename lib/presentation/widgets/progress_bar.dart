import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  final double? height;
  final Color? color;

  const ProgressBar({
    super.key,
    required this.value,
    this.height = 8,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      child: Stack(
        children: [
          Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withValues(alpha: 0.1),
            ),
          ),
          FractionallySizedBox(
            widthFactor: value,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: color ?? context.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
