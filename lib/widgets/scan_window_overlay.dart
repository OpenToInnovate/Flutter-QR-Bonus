import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Custom painter that creates a hole in the overlay for the scan window
class ScanWindowOverlay extends StatelessWidget {
  /// The rectangle where the scan window should be
  final Rect scanRect;
  
  /// The scan window border color
  final Color borderColor;
  
  /// The overlay background color
  final Color overlayColor;
  
  /// The border radius for the scan window
  final double borderRadius;
  
  /// The border width for the scan window
  final double borderWidth;
  
  const ScanWindowOverlay({
    super.key,
    required this.scanRect,
    this.borderColor = Colors.white,
    this.overlayColor = Colors.black,
    this.borderRadius = AppConstants.scanWindowBorderRadius,
    this.borderWidth = AppConstants.scanWindowBorderWidth,
  });
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Overlay with hole
        IgnorePointer(
          child: CustomPaint(
            painter: _HolePainter(
              rect: scanRect,
              overlayColor: overlayColor,
              borderRadius: borderRadius,
            ),
            child: const SizedBox.expand(),
          ),
        ),
        // Scan window border
        IgnorePointer(
          child: Center(
            child: Container(
              width: scanRect.width,
              height: scanRect.height,
              decoration: BoxDecoration(
                border: Border.all(
                  width: borderWidth,
                  color: borderColor,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Custom painter that creates a hole in the overlay
class _HolePainter extends CustomPainter {
  /// The rectangle to cut out
  final Rect rect;
  
  /// The overlay background color
  final Color overlayColor;
  
  /// The border radius for the cutout
  final double borderRadius;
  
  _HolePainter({
    required this.rect,
    required this.overlayColor,
    required this.borderRadius,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    // Create background paint with opacity
    final backgroundPaint = Paint()
      ..color = overlayColor.withValues(alpha: AppConstants.overlayOpacity);
    
    // Create the full overlay path
    final overlayPath = Path()..addRect(Offset.zero & size);
    
    // Create the cutout path with rounded corners
    final cutoutPath = Path()
      ..addRRect(RRect.fromRectXY(rect, borderRadius, borderRadius));
    
    // Combine paths to create the hole
    final resultPath = Path.combine(
      PathOperation.difference,
      overlayPath,
      cutoutPath,
    );
    
    // Draw the result
    canvas.drawPath(resultPath, backgroundPaint);
  }
  
  @override
  bool shouldRepaint(covariant _HolePainter oldDelegate) {
    return oldDelegate.rect != rect ||
        oldDelegate.overlayColor != overlayColor ||
        oldDelegate.borderRadius != borderRadius;
  }
}
