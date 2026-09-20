import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

/// Fades and lifts its child the first time it enters the viewport.
///
/// No controller is kept alive after the entrance animation, and users who
/// request reduced motion see the final state immediately.
class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    required this.child,
    super.key,
    this.delay = Duration.zero,
    this.offset = 28,
  });

  final Widget child;
  final Duration delay;
  final double offset;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  ScrollPosition? _position;
  bool _visible = false;
  bool _scheduled = false;
  bool _pendingDelay = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context)?.position;
    if (_position != position) {
      _position?.removeListener(_checkVisibility);
      _position = position?..addListener(_checkVisibility);
    }
    _scheduleCheck();
  }

  void _scheduleCheck() {
    if (_scheduled || _visible) return;
    _scheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scheduled = false;
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (!mounted || _visible || _pendingDelay) return;
    if (MediaQuery.maybeOf(context)?.disableAnimations ?? false) {
      setState(() => _visible = true);
      return;
    }
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final viewportHeight = MediaQuery.sizeOf(context).height;
    if (top < viewportHeight * .9) {
      if (widget.delay == Duration.zero) {
        setState(() => _visible = true);
      } else {
        _pendingDelay = true;
        Future<void>.delayed(widget.delay, () {
          if (mounted) setState(() => _visible = true);
        });
      }
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_checkVisibility);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final shown = _visible || reduceMotion;
    return AnimatedOpacity(
      opacity: shown ? 1 : 0,
      duration: reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      child: AnimatedSlide(
        offset: shown ? Offset.zero : Offset(0, widget.offset / 100),
        duration: reduceMotion
            ? Duration.zero
            : const Duration(milliseconds: 650),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

/// A restrained desktop hover treatment. Touch devices retain the same layout.
class HoverLift extends StatefulWidget {
  const HoverLift({required this.child, super.key, this.borderRadius = 18});

  final Widget child;
  final double borderRadius;

  @override
  State<HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<HoverLift> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final active = _hovered && !reduceMotion;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(
          active ? 1.012 : 1,
          active ? 1.012 : 1,
          1,
        )..setTranslationRaw(0, active ? -4 : 0, 0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: active
              ? const [
                  BoxShadow(
                    color: Color(0x22123C49),
                    blurRadius: 24,
                    offset: Offset(0, 10),
                  ),
                ]
              : const [],
        ),
        child: widget.child,
      ),
    );
  }
}

/// Gently zooms media and washes it with a warm translucent overlay on hover.
class HoverMedia extends StatefulWidget {
  const HoverMedia({required this.child, super.key});

  final Widget child;

  @override
  State<HoverMedia> createState() => _HoverMediaState();
}

class _HoverMediaState extends State<HoverMedia> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final active = _hovered && !reduceMotion;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: ClipRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedScale(
              scale: active ? 1.035 : 1,
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
              child: widget.child,
            ),
            IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                color: AppColors.accent.withValues(alpha: active ? .08 : 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
