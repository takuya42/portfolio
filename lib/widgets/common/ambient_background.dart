import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Warm natural light and out-of-focus foliage used behind the hero.
///
/// Each plant has its own long animation cycle. The silhouettes are painted as
/// stems with pointed, asymmetric leaves rather than a collection of ovals.
class AmbientBackground extends StatefulWidget {
  const AmbientBackground({required this.child, super.key});

  final Widget child;

  @override
  State<AmbientBackground> createState() => _AmbientBackgroundState();
}

class _AmbientBackgroundState extends State<AmbientBackground>
    with TickerProviderStateMixin {
  late final AnimationController _topLeft;
  late final AnimationController _bottomLeft;
  late final AnimationController _center;

  @override
  void initState() {
    super.initState();
    _topLeft = _controller(const Duration(seconds: 25));
    _bottomLeft = _controller(const Duration(seconds: 30));
    _center = _controller(const Duration(seconds: 35));
  }

  AnimationController _controller(Duration duration) => AnimationController(
    vsync: this,
    duration: duration,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controllers = [_topLeft, _bottomLeft, _center];
    if (MediaQuery.disableAnimationsOf(context)) {
      for (final controller in controllers) {
        controller.stop();
        controller.value = .42;
      }
    } else {
      for (final controller in controllers) {
        if (!controller.isAnimating) controller.repeat(reverse: true);
      }
    }
  }

  @override
  void dispose() {
    _topLeft.dispose();
    _bottomLeft.dispose();
    _center.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          const Positioned.fill(child: _NaturalLight()),
          Positioned(
            left: -145,
            top: -155,
            width: 470,
            height: 500,
            child: _MovingPlant(
              animation: _topLeft,
              travel: const Offset(7, 9),
              rotation: .018,
              opacity: .18,
              blur: 22,
              angle: -.14,
            ),
          ),
          Positioned(
            left: -175,
            bottom: -175,
            width: 560,
            height: 590,
            child: _MovingPlant(
              animation: _bottomLeft,
              travel: const Offset(10, -7),
              rotation: -.015,
              opacity: .25,
              blur: 19,
              angle: -.82,
            ),
          ),
          Positioned(
            left: MediaQuery.sizeOf(context).width * .36,
            top: -170,
            width: 410,
            height: 410,
            child: _MovingPlant(
              animation: _center,
              travel: const Offset(6, 5),
              rotation: .012,
              opacity: .09,
              blur: 27,
              angle: .34,
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class _NaturalLight extends StatelessWidget {
  const _NaturalLight();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xFFF8F4EC),
        gradient: LinearGradient(
          begin: Alignment(-1, -1),
          end: Alignment(1, 1),
          colors: [Color(0xFFFFFDF7), Color(0xFFF8F4EC), Color(0xFFF1EBDD)],
          stops: [0, .58, 1],
        ),
      ),
    );
  }
}

class _MovingPlant extends StatelessWidget {
  const _MovingPlant({
    required this.animation,
    required this.travel,
    required this.rotation,
    required this.opacity,
    required this.blur,
    required this.angle,
  });

  final Animation<double> animation;
  final Offset travel;
  final double rotation;
  final double opacity;
  final double blur;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final breeze = Curves.easeInOut.transform(animation.value) - .5;
          return Transform.translate(
            offset: travel * breeze,
            child: Transform.rotate(
              angle: angle + rotation * breeze,
              child: CustomPaint(
                painter: _BranchPainter(opacity: opacity, blur: blur),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A small foreground branch that can overlap photography without obscuring it.
class HeroForegroundLeaves extends StatelessWidget {
  const HeroForegroundLeaves({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Transform.rotate(
        angle: -.48,
        child: CustomPaint(
          painter: const _BranchPainter(opacity: .2, blur: 10),
        ),
      ),
    );
  }
}

class _BranchPainter extends CustomPainter {
  const _BranchPainter({required this.opacity, required this.blur});

  final double opacity;
  final double blur;

  @override
  void paint(Canvas canvas, Size size) {
    final olive = Color.fromRGBO(82, 94, 54, opacity);
    final foliage = Paint()
      ..color = olive
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);
    final stem = Paint()
      ..color = Color.fromRGBO(76, 86, 49, opacity * .72)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(2, size.shortestSide * .012)
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur * .65);

    final branch = Path()
      ..moveTo(size.width * .08, size.height * .98)
      ..cubicTo(
        size.width * .2,
        size.height * .72,
        size.width * .47,
        size.height * .48,
        size.width * .74,
        size.height * .08,
      );
    canvas.drawPath(branch, stem);

    const leaves = <(double, double, double, double)>[
      (.18, .80, -2.50, .24),
      (.25, .70, -.58, .29),
      (.33, .63, -2.52, .31),
      (.42, .53, -.55, .34),
      (.50, .45, -2.48, .3),
      (.58, .34, -.48, .31),
      (.65, .24, -2.42, .27),
      (.72, .12, -.63, .24),
    ];
    for (final leaf in leaves) {
      _paintLeaf(
        canvas,
        Offset(size.width * leaf.$1, size.height * leaf.$2),
        size.shortestSide * leaf.$4,
        leaf.$3,
        foliage,
        stem,
      );
    }
  }

  void _paintLeaf(
    Canvas canvas,
    Offset base,
    double length,
    double angle,
    Paint foliage,
    Paint stem,
  ) {
    canvas.save();
    canvas.translate(base.dx, base.dy);
    canvas.rotate(angle);
    canvas.drawLine(Offset.zero, Offset(length * .22, 0), stem);
    final leaf = Path()
      ..moveTo(length * .16, 0)
      ..cubicTo(length * .34, -length * .28, length * .8, -length * .25, length, 0)
      ..cubicTo(length * .72, length * .22, length * .34, length * .25, length * .16, 0)
      ..close();
    canvas.drawPath(leaf, foliage);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_BranchPainter oldDelegate) =>
      oldDelegate.opacity != opacity || oldDelegate.blur != blur;
}
