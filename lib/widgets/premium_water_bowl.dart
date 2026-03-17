import 'dart:math';
import 'package:flutter/material.dart';
import "premium_wave_painter.dart";

class WaterBowlPremium extends StatefulWidget {
  final double progress;
  final Color color;
  final String text;

  const WaterBowlPremium({
    super.key,
    required this.progress,
    required this.color,
    required this.text,
  });

  @override
  State<WaterBowlPremium> createState() => _WaterBowlPremiumState();
}

class _WaterBowlPremiumState extends State<WaterBowlPremium>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final Random random = Random();
  late List<Bubble> bubbles;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Create some random bubbles
    bubbles = List.generate(15, (index) => Bubble(random));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1, end: 1 - widget.progress),
      duration: const Duration(milliseconds: 800),
      builder: (context, level, _) {
        return Container(
          width: 240,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 3),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(120),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: controller,
                  builder: (_, __) {
                    return CustomPaint(
                      size: Size.infinite,
                      painter: WaterPainterPremium(
                        level,
                        widget.color,
                        controller.value,
                        bubbles,
                      ),
                    );
                  },
                ),
                Text(
                  widget.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black45,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
