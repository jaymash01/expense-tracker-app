import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class FormLabelControl extends StatelessWidget {
  final bool required;
  final String label;
  final Widget child;

  const FormLabelControl({
    super.key,
    this.required = false,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            bottom: AppDimensions.spaceS + AppDimensions.spaceXS,
          ),
          child: Row(
            children: <Widget>[
              Text(label, style: context.textTheme.titleSmall),
              if (required) SizedBox(width: AppDimensions.spaceXS),
              if (required)
                Text(
                  '*',
                  style: context.textTheme.titleSmall!.merge(
                    TextStyle(color: context.colorScheme.error),
                  ),
                ),
            ],
          ),
        ),
        child,
      ],
    );
  }
}
