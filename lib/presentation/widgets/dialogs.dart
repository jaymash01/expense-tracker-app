import 'package:expense_tracker/core/config/app_dimensions.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static void showAlertDialog(
    BuildContext context,
    String message, [
    VoidCallback? onOk,
  ]) {
    Navigator.of(context).push(
      _DialogRoute(
        dismissOnTapBarrier: onOk == null,
        child: _AlertDialogChild(
          message: message,
          onDismiss: () {
            Navigator.pop(context);

            if (onOk != null) {
              onOk();
            }
          },
        ),
      ),
    );
  }

  static void showConfirmationDialog(
    BuildContext context,
    String title,
    String message,
    VoidCallback onOk, [
    String cancelText = 'No',
    String okText = 'Yes',
  ]) {
    Navigator.of(context).push(
      _DialogRoute(
        dismissOnTapBarrier: false,
        child: _ConfirmationDialogChild(
          title: title,
          message: message,
          onCancel: () => Navigator.pop(context),
          onOk: onOk,
          cancelText: cancelText,
          okText: okText,
        ),
      ),
    );
  }

  static void showNetworkImageDialog(
    BuildContext context,
    String path,
    VoidCallback? onDismiss,
  ) {
    Navigator.of(context).push(
      _DialogRoute(
        dismissOnTapBarrier: true,
        child: _NetworkImageDialogChild(path: path, onDismiss: onDismiss),
      ),
    );
  }

  static void showBottomSheet(
    BuildContext context,
    String title,
    Widget child, [
    String subtitle = '',
  ]) {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return _BottomSheetChild(
          title: title,
          subtitle: subtitle,
          child: child,
          onDismiss: () => Navigator.pop(context),
        );
      },
    );
  }
}

class _DialogRoute extends ModalRoute<void> {
  final bool dismissOnTapBarrier;
  final Widget child;

  _DialogRoute({required this.dismissOnTapBarrier, required this.child});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => dismissOnTapBarrier;

  @override
  Color get barrierColor => Colors.black54;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // Make sure that the overlay content is not cut off
      child: SafeArea(child: Center(child: child)),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(scale: animation, child: child),
    );
  }
}

class _AlertDialogChild extends StatelessWidget {
  final String message;
  final VoidCallback? onDismiss;

  const _AlertDialogChild({
    super.key,
    required this.message,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Card(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.all(AppDimensions.spaceXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(AppDimensions.spaceL),
                child: Text(
                  message,
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(height: 1.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.spaceS),
                child: TextButton(
                  onPressed: onDismiss,
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConfirmationDialogChild extends StatelessWidget {
  final String? title;
  final String message;
  final VoidCallback? onCancel;
  final VoidCallback? onOk;
  final String? cancelText;
  final String? okText;

  const _ConfirmationDialogChild({
    super.key,
    this.title,
    required this.message,
    this.onCancel,
    this.onOk,
    this.cancelText = 'Cancel',
    this.okText = 'OK',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Card(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.all(AppDimensions.spaceXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(AppDimensions.spaceM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if ((title ?? '').isNotEmpty)
                      Text(
                        title!,
                        style: context.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    if ((title ?? '').isNotEmpty)
                      SizedBox(height: AppDimensions.spaceM),
                    Text(
                      message,
                      style: context.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Divider(height: 1.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.spaceS),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                          onPressed: onCancel,
                          child: Text(cancelText!),
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: TextButton(
                          onPressed: onOk,
                          child: Text(okText!),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NetworkImageDialogChild extends StatelessWidget {
  final String path;
  final VoidCallback? onDismiss;

  const _NetworkImageDialogChild({
    super.key,
    required this.path,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: EdgeInsets.zero,
      minScale: 0.1,
      maxScale: 3,
      //constrained: false,
      child: Image.network(
        path,
        fit: BoxFit.fitWidth,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
              return Icon(
                Icons.photo_rounded,
                color: context.colorScheme.secondary,
                size: 72.0,
              );
            },
      ),
    );
  }
}

class _BottomSheetChild extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget child;
  final VoidCallback? onDismiss;

  const _BottomSheetChild({
    super.key,
    this.title,
    this.subtitle,
    required this.child,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final navBarPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(color: context.colorScheme.surface),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: navBarPadding + bottomInset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if ((title ?? '').isNotEmpty)
              ListTile(
                title: Text(title!, style: context.textTheme.titleLarge),
                subtitle: (subtitle ?? '').isNotEmpty ? Text(subtitle!) : null,
                trailing: GestureDetector(
                  onTap: onDismiss,
                  child: const Icon(Icons.close_rounded),
                ),
                minTileHeight: 56.0,
              ),
            if ((title ?? '').isNotEmpty) const Divider(height: 1.0),
            child,
          ],
        ),
      ),
    );
  }
}
