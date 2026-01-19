import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:flutter/material.dart';

class PopupMenuItemContent extends StatelessWidget {
  final Icon? icon;
  final String label;
  final int? badge;

  const PopupMenuItemContent({
    super.key,
    this.icon,
    required this.label,
    this.badge = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceM,
        vertical: AppDimensions.spaceS,
      ),
      child: Row(
        children: <Widget>[
          if (icon != null) icon!,
          if (icon != null)
            SizedBox(width: AppDimensions.spaceM - AppDimensions.spaceXS),
          Expanded(child: Text(label)),
          if (badge != 0)
            SizedBox(width: AppDimensions.spaceM - AppDimensions.spaceXS),
          if (badge != 0) Badge(label: Text('$badge')),
        ],
      ),
    );
  }
}
