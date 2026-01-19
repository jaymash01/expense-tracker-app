import 'dart:math' as math;
import 'dart:ui' show lerpDouble;
import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class LoadingButton extends ElevatedButton {
  LoadingButton({
    super.key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    super.onHover,
    super.onFocusChange,
    super.focusNode,
    super.style,
    super.statesController,
    bool? autofocus,
    Clip? clipBehavior,
    required bool loading,
    required Widget child,
    Widget? loadingIndicator,
    String? loadingText,
  }) : super(
         onPressed: loading ? null : onPressed,
         onLongPress: loading ? null : onLongPress,
         autofocus: autofocus ?? false,
         clipBehavior: clipBehavior ?? Clip.none,
         child: _LoadingButtonChild(
           loading: loading,
           label: child,
           loadingIndicator: loadingIndicator,
           loadingText: loadingText,
         ),
       );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsetsDirectional.fromSTEB(16, 0, 24, 0),
      const EdgeInsetsDirectional.fromSTEB(8, 0, 12, 0),
      const EdgeInsetsDirectional.fromSTEB(4, 0, 6, 0),
      MediaQuery.textScalerOf(context).scale(14),
    );
    return super
        .defaultStyleOf(context)
        .copyWith(
          padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(scaledPadding),
          // Keep consistent disabled foreground when loading
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return context.colorScheme.onSurface;
            }
            return null;
          }),
        );
  }
}

class _LoadingButtonChild extends StatelessWidget {
  final bool loading;
  final Widget label;
  final Widget? loadingIndicator;
  final String? loadingText;

  const _LoadingButtonChild({
    required this.loading,
    required this.label,
    this.loadingIndicator,
    this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(14.0);
    final double size = textScale <= 1
        ? 24.0
        : lerpDouble(24.0, 12.0, math.min(textScale - 1, 1))!;

    if (!loading) return label;

    final indicator =
        loadingIndicator ??
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: context.colorScheme.onPrimary,
          ),
        );

    if (loadingText != null && loadingText!.isNotEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          indicator,
          SizedBox(width: AppDimensions.spaceM),
          Text(
            loadingText!,
            style: TextStyle(color: context.colorScheme.onPrimary),
          ),
        ],
      );
    }

    return indicator;
  }
}
