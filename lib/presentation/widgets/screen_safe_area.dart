import 'package:flutter/material.dart';

class ScreenSafeArea extends StatelessWidget {
  final Widget? child;
  final bool includeTop;
  final bool includeBottom;

  const ScreenSafeArea({
    super.key,
    this.child,
    this.includeTop = false,
    this.includeBottom = true,
  });

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Padding(
      padding: EdgeInsets.only(
        top: includeTop ? padding.top : 0,
        bottom: includeBottom ? padding.bottom : 0,
      ),
      child: child,
    );
  }
}
