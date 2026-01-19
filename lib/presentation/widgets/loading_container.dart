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
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(),
          ),
        SizedBox(
          width: size,
          height: size,
          child: Center(
            child: SizedBox(
              width: size - 6,
              height: size - 6,
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
