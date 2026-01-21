import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isLoading;

  const LoadingIndicator({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Padding(
            padding: EdgeInsets.all(AppDimensions.spaceM),
            child: Center(child: CircularProgressIndicator()),
          )
        : SizedBox.shrink();
  }
}
