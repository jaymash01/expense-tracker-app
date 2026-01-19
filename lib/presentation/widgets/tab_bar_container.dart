import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class TabBarContainer extends StatelessWidget implements PreferredSizeWidget {
  final TabBar child;

  const TabBarContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.spaceM),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: BoxBorder.fromBorderSide(
            BorderSide(color: context.colorScheme.outline, width: 0.5),
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
