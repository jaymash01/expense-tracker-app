import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/core/config/app_dimensions.dart';

import 'animated_widget.dart';

enum AlertPosition { top, bottom }

enum AlertType { normal, info, success, error, warning }

class AppAlert extends StatefulWidget {
  final String message;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final Duration duration;
  final AlertPosition position;
  final VoidCallback onDismissed;
  final AlertType type;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  const AppAlert({
    super.key,
    required this.message,
    this.icon,
    required this.backgroundColor,
    required this.textColor,
    this.duration = const Duration(seconds: 3),
    this.position = AlertPosition.bottom,
    required this.onDismissed,
    this.type = AlertType.normal,
    this.actionLabel,
    this.onActionPressed,
  });

  @override
  State<AppAlert> createState() => _AppAlertState();
}

class _AppAlertState extends State<AppAlert>
    with SingleTickerProviderStateMixin {
  double _dismissProgress = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(widget.duration, () {
      if (mounted) {
        widget.onDismissed();
      }
    });
  }

  IconData? _getIconForType() {
    if (widget.icon != null) return widget.icon;

    switch (widget.type) {
      case AlertType.success:
        return Icons.check_circle_outline;
      case AlertType.error:
        return Icons.error_outline;
      case AlertType.warning:
        return Icons.warning_amber_outlined;
      case AlertType.info:
        return Icons.info_outline;
      default:
        return null;
    }
  }

  Color _getColorForType() {
    if (widget.type == AlertType.normal) return widget.backgroundColor;

    final appColors = context.appColors;

    switch (widget.type) {
      case AlertType.info:
        return appColors.info ?? Colors.blue;
      case AlertType.success:
        return appColors.success ?? Colors.green;
      case AlertType.error:
        return Theme.of(context).colorScheme.error;
      case AlertType.warning:
        return appColors.warning ?? Colors.orange;
      default:
        return widget.backgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getColorForType();
    final icon = _getIconForType();
    final textTheme = Theme.of(context).textTheme;

    final snackbarContent = GestureDetector(
      onVerticalDragStart: (_) {},
      onVerticalDragUpdate: (details) {
        final delta = widget.position == AlertPosition.top
            ? details.delta.dy
            : -details.delta.dy;

        setState(() {
          _dismissProgress += delta / 150;
          _dismissProgress = _dismissProgress.clamp(0.0, 1.0);
        });

        if (_dismissProgress >= 0.5 && mounted) {
          widget.onDismissed();
        }
      },
      onVerticalDragEnd: (_) {
        setState(() {
          _dismissProgress = 0.0;
        });
      },
      child: Material(
        elevation: AppDimensions.elevationM,
        shadowColor: backgroundColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [backgroundColor, backgroundColor.withValues(alpha: 0.8)],
            ),
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceM,
                  vertical: AppDimensions.spaceS,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        color: widget.textColor,
                        size: AppDimensions.iconSizeS,
                      ),
                      const SizedBox(width: AppDimensions.spaceS),
                    ],
                    Flexible(
                      child: Text(
                        widget.message,
                        style: textTheme.bodySmall?.copyWith(
                          color: widget.textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (widget.actionLabel != null &&
                        widget.onActionPressed != null) ...[
                      const SizedBox(width: AppDimensions.spaceS),
                      TextButton(
                        onPressed: widget.onActionPressed,
                        style: TextButton.styleFrom(
                          foregroundColor: widget.textColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.spaceS,
                            vertical: AppDimensions.spaceXS,
                          ),
                          textStyle: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text(widget.actionLabel!),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (widget.position == AlertPosition.top) {
      return AnimatedSlideInDown(
        duration: AppDimensions.durationNormal,
        child: snackbarContent,
      );
    } else {
      return AnimatedSlideInUp(
        duration: AppDimensions.durationNormal,
        child: snackbarContent,
      );
    }
  }
}

// Helper function to show the custom snackbar
void appAlert(
  BuildContext context,
  String message, {
  IconData? icon,
  Color? backgroundColor,
  Color? textColor,
  Duration duration = const Duration(seconds: 5),
  AlertPosition position = AlertPosition.top,
  AlertType type = AlertType.normal,
  String? actionLabel,
  VoidCallback? onActionPressed,
}) {
  final colorScheme = Theme.of(context).colorScheme;

  backgroundColor ??= colorScheme.primary;
  textColor ??= colorScheme.onPrimary;

  OverlayEntry? overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) {
      Alignment alignment;
      EdgeInsets padding;
      if (position == AlertPosition.top) {
        alignment = Alignment.topCenter;
        padding = EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + AppDimensions.spaceM,
          left: AppDimensions.spaceM,
          right: AppDimensions.spaceM,
        );
      } else {
        alignment = Alignment.bottomCenter;
        padding = EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + AppDimensions.spaceM,
          left: AppDimensions.spaceM,
          right: AppDimensions.spaceM,
        );
      }

      return Align(
        alignment: alignment,
        child: Padding(
          padding: padding,
          child: AppAlert(
            message: message,
            icon: icon,
            backgroundColor: backgroundColor!,
            textColor: textColor!,
            duration: duration,
            position: position,
            type: type,
            actionLabel: actionLabel,
            onActionPressed: onActionPressed,
            onDismissed: () {
              overlayEntry?.remove();
            },
          ),
        ),
      );
    },
  );

  Overlay.of(context).insert(overlayEntry);
}
