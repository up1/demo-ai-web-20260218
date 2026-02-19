import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/wave_clipper.dart';

/// The coral-pink header with a topographic pattern overlay and a
/// wave-shaped clip at the bottom, used on both the Welcome and
/// Login screens.
class CoralHeader extends StatelessWidget {
  /// Creates a coral header.
  ///
  /// [heightFraction] controls how much of the screen the header
  /// occupies (0.0–1.0). Defaults to 0.6.
  const CoralHeader({super.key, this.heightFraction = 0.6});

  /// Fraction of the screen height that the header fills.
  final double heightFraction;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: MediaQuery.sizeOf(context).height * heightFraction,
        decoration: const BoxDecoration(color: AppColors.primary),
        child: CustomPaint(painter: _TopographicPainter(), size: Size.infinite),
      ),
    );
  }
}

/// Draws subtle topographic-style circular lines on the coral
/// background to replicate the pattern from the Figma design.
class _TopographicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final centers = [
      Offset(size.width * 0.3, size.height * 0.3),
      Offset(size.width * 0.7, size.height * 0.5),
      Offset(size.width * 0.1, size.height * 0.7),
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width * 0.5, size.height * 0.6),
    ];

    for (final center in centers) {
      for (var i = 1; i <= 5; i++) {
        canvas.drawOval(
          Rect.fromCenter(center: center, width: i * 50.0, height: i * 40.0),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
