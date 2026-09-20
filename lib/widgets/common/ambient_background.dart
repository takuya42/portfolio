import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

/// A quiet, reusable salon backdrop made entirely with Flutter primitives.
///
/// The long animation cycle is intentional: the light and botanical shadows
/// should be felt rather than watched. Reduced-motion preferences are honored.
class AmbientBackground extends StatefulWidget {
  const AmbientBackground({required this.child, super.key});

  final Widget child;

  @override
  State<AmbientBackground> createState() => _AmbientBackgroundState();
}

class _AmbientBackgroundState extends State<AmbientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (context, child) {
          final phase = MediaQuery.disableAnimationsOf(context)
              ? .35
              : _controller.value;
          return Stack(
            children: [
              const Positioned.fill(child: _SoftGradient()),
              Positioned(
                top: -170 + (phase * 18),
                right: -110 + (phase * 14),
                child: _BlurredOrb(
                  size: 430,
                  color: AppColors.white.withValues(alpha: .42),
                ),
              ),
              Positioned(
                bottom: -210 + (phase * 22),
                left: -150 + (phase * 10),
                child: _BlurredOrb(
                  size: 480,
                  color: AppColors.sand.withValues(alpha: .32),
                ),
              ),
              Positioned.fill(
                child: Transform.translate(
                  offset: Offset(phase * 7, phase * 4),
                  child: Transform.rotate(
                    angle: (phase - .5) * .012,
                    alignment: Alignment.topRight,
                    child: CustomPaint(
                      painter: _BotanicalLightPainter(progress: phase),
                    ),
                  ),
                ),
              ),
              if (child != null) child,
            ],
          );
        },
      ),
    );
  }
}

class _SoftGradient extends StatelessWidget {
  const _SoftGradient();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFEFB), Color(0xFFF1E9DE), Color(0xFFF8F5EF)],
          stops: [0, .52, 1],
        ),
      ),
    );
  }
}

class _BlurredOrb extends StatelessWidget {
  const _BlurredOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(color: color, blurRadius: 80, spreadRadius: 34),
        ],
      ),
    );
  }
}

class _BotanicalLightPainter extends CustomPainter {
  const _BotanicalLightPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final shadow = Paint()
      ..color = AppColors.taupe.withValues(alpha: .065)
      ..style = PaintingStyle.fill;
    final stem = Paint()
      ..color = AppColors.taupe.withValues(alpha: .1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    final origin = Offset(size.width * .9, -30);
    final path = Path()
      ..moveTo(origin.dx, origin.dy)
      ..cubicTo(
        size.width * .84,
        size.height * .18,
        size.width * .91,
        size.height * .34,
        size.width * .76,
        size.height * .55,
      );
    canvas.drawPath(path, stem);

    for (var index = 0; index < 7; index++) {
      final distance = index / 7;
      final center = Offset(
        size.width * (.89 - distance * .12),
        size.height * (.08 + distance * .44),
      );
      final side = index.isEven ? 1.0 : -1.0;
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(side * (.35 + math.sin(progress * math.pi) * .02));
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(side * 31, 0),
          width: 82,
          height: 29,
        ),
        shadow,
      );
      canvas.restore();
    }

    final curve = Paint()
      ..color = AppColors.accent.withValues(alpha: .14 * progress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = .8;
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width * .08, size.height * .73),
        radius: size.width * .24,
      ),
      -1.1,
      1.8,
      false,
      curve,
    );
  }

  @override
  bool shouldRepaint(_BotanicalLightPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
