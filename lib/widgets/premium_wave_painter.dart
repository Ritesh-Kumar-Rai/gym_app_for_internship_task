import 'dart:math';
import 'package:flutter/material.dart';

class Bubble {
  double x;
  double y;
  double radius;
  double speed;

  Bubble(Random random)
    : x = random.nextDouble(),
      y = random.nextDouble(),
      radius = random.nextDouble() * 6 + 2,
      speed = random.nextDouble() * 0.003 + 0.001;
}

class WaterPainterPremium extends CustomPainter {
  final double level;
  final Color color;
  final double animation;
  final List<Bubble> bubbles;

  WaterPainterPremium(this.level, this.color, this.animation, this.bubbles);

  final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    // Draw gradient water
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [color.withOpacity(0.7), color.withOpacity(0.9)],
    );
    final Paint paint = Paint()..shader = gradient.createShader(rect);

    // 3 Waves
    for (int wave = 0; wave < 3; wave++) {
      final path = Path();
      double baseHeight = size.height * level;
      path.moveTo(0, baseHeight);
      double amplitude = 5 + wave * 2;
      double speedOffset = wave * pi / 2;

      for (double i = 0; i <= size.width; i++) {
        path.lineTo(
          i,
          baseHeight +
              amplitude *
                  sin(
                    (i / size.width * 2 * pi) +
                        animation * 2 * pi +
                        speedOffset,
                  ),
        );
      }

      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      canvas.drawPath(path, paint);
    }

    // Draw bubbles
    // final bubblePaint = Paint()..color = Colors.white.withOpacity(0.7);
    // for (var bubble in bubbles) {
    //   double x = bubble.x * size.width;
    //   double y = (bubble.y - animation * bubble.speed * 50) * size.height;
    //   y = y % size.height;
    //   canvas.drawCircle(Offset(x, y), bubble.radius, bubblePaint);
    // }
    for (var bubble in bubbles) {
      // move bubble upward smoothly
      bubble.y -= bubble.speed;

      // if bubble reaches top
      if (bubble.y < 0) {
        bubble.y = 1.0; // restart from bottom
        bubble.x = random.nextDouble();
        bubble.radius = random.nextDouble() * 5 + 2;
      }

      double xPos = bubble.x * size.width;
      double yPos = bubble.y * size.height;

      // fade near surface
      double opacity = (yPos / size.height).clamp(0.0, 1.0);

      canvas.drawCircle(
        Offset(xPos, yPos),
        bubble.radius,
        Paint()
          ..color = Colors.white.withOpacity(0.6 * opacity)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
      );
    }
    // reflection code
    Path reflection = Path();
    reflection.moveTo(0, 0);
    reflection.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.1,
      size.width,
      0,
    );
    reflection.lineTo(size.width, size.height * 0.2);
    reflection.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.15,
      0,
      size.height * 0.2,
    );
    reflection.close();

    canvas.drawPath(
      reflection,
      Paint()
        ..shader = LinearGradient(
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
