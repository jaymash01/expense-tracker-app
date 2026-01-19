import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  final Color? color;
  final double height;
  final double thickness;
  final double dashLength;
  final double dashSpacing;
  final double indent;
  final double endIndent;

  const DashedDivider({
    super.key,
    this.color,
    this.height = 16.0,
    this.thickness =  1.0,
    this.dashLength = 5.0,
    this.dashSpacing = 3.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = color ?? context.colorScheme.outline;

    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          height: thickness,
          margin: EdgeInsetsDirectional.only(start: indent, end: endIndent),
          child: CustomPaint(
            painter: _DashedLinePainter(
              color: effectiveColor,
              dashLength: dashLength,
              dashSpacing: dashSpacing,
              strokeWidth: thickness,
            ),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashLength;
  final double dashSpacing;
  final double strokeWidth;

  _DashedLinePainter({
    required this.color,
    required this.dashLength,
    required this.dashSpacing,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startX = 0;
    final double endX = size.width;
    final dashSpace = dashLength + dashSpacing;

    while (startX < endX) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashLength, 0), paint);
      startX += dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.dashSpacing != dashSpacing ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
