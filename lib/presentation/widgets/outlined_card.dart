import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class OutlinedCard extends Card {
  final double borderRadius;

  const OutlinedCard({
    super.key,
    super.child,
    super.color,
    super.elevation = 0,
    super.margin,
    super.clipBehavior,
    super.shadowColor,
    super.surfaceTintColor,
    super.semanticContainer = true,
    this.borderRadius = AppDimensions.radiusL,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: elevation,
      margin: margin,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      semanticContainer: semanticContainer,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.5, color: context.colorScheme.outline),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
