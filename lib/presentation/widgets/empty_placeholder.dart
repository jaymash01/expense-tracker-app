import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class EmptyPlaceholder extends StatelessWidget {
  final String title;
  final String? description;
  final double height;

  const EmptyPlaceholder({
    super.key,
    this.title = 'No data yet',
    this.description,
    this.height = 500.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/no_data.png',
            width: 200.0,
            fit: BoxFit.fitWidth,
          ),
          Text(
            title,
            style: context.textTheme.titleMedium!.copyWith(
              color: context.textTheme.bodySmall!.color,
            ),
          ),
          if (description != null) SizedBox(height: AppDimensions.spaceXXS),
          if (description != null)
            Text(description!, style: context.textTheme.bodySmall),
        ],
      ),
    );
  }
}
