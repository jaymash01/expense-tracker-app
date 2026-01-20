import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final bool loading;
  final double size;
  final Widget? child;

  const LoadingContainer({
    super.key,
    this.loading = false,
    this.size = 40.0,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (loading)
          SizedBox.square(dimension: size, child: CircularProgressIndicator()),
        SizedBox.square(
          dimension: size,
          child: Center(
            child: SizedBox.square(
              dimension: size - 6,
              child: Card(
                elevation: 0,
                clipBehavior: Clip.hardEdge,
                color: context.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size / 2),
                ),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
