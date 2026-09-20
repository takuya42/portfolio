import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../../core/salon_data.dart';
import '../common/motion.dart';
import '../common/salon_image.dart';
import '../common/section_container.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({required this.onContactTap, super.key});

  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          const Positioned.fill(child: _HeroBackground()),
          Positioned.fill(
            child: ColoredBox(color: AppColors.ivory.withValues(alpha: .38)),
          ),
          SectionContainer(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.fromLTRB(
              context.horizontalPadding,
              context.isMobile ? 28 : 48,
              context.horizontalPadding,
              context.isMobile ? 64 : 90,
            ),
            child: context.isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCopy(context),
                      const SizedBox(height: 38),
                      _buildVisual(context),
                    ],
                  )
                : Row(
                    children: [
                      // Give the copy enough room for the intended two-line
                      // headline without sacrificing its display size.
                      Expanded(flex: 10, child: _buildCopy(context)),
                      const SizedBox(width: 44),
                      Expanded(flex: 9, child: _buildVisual(context)),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCopy(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RevealOnScroll(
          child: Text(
            SalonData.tagline,
            style: TextStyle(
              color: AppColors.accent,
              letterSpacing: 3,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const RevealOnScroll(
          delay: Duration(milliseconds: 100),
          child: _HeroTitle(),
        ),
        const SizedBox(height: 24),
        RevealOnScroll(
          delay: const Duration(milliseconds: 200),
          child: Text(
            '髪に触れる時間が、心まで軽くする。\nあなたらしさに寄り添うヘアサロンです。',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 30),
        RevealOnScroll(
          delay: const Duration(milliseconds: 300),
          child: HoverLift(
            borderRadius: 2,
            child: FilledButton(
              onPressed: onContactTap,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('ご予約はこちら'),
                  SizedBox(width: 24),
                  Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVisual(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AspectRatio(
          aspectRatio: context.isMobile ? .82 : 1.18,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.white.withValues(alpha: .7)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x2E292724),
                  blurRadius: 30,
                  offset: Offset(0, 14),
                ),
              ],
            ),
            child: _HeroImageEntrance(
              child: SalonImage(
                assetPath: AppAssets.hero,
                semanticLabel: 'サロンのメインビジュアル',
                fit: BoxFit.cover,
                alignment: Alignment(.35, 0),
              ),
            ),
          ),
        ),
        Positioned(
          left: context.isMobile ? 14 : -28,
          top: context.isMobile ? 16 : 34,
          child: const _VerticalCaption(),
        ),
        Positioned(
          right: context.isMobile ? 12 : -20,
          bottom: -22,
          child: Container(
            color: AppColors.charcoal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: const Text(
              'BEAUTY IN YOUR WAY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                letterSpacing: 2.4,
              ),
            ),
          ),
        ),
        Positioned(
          right: context.isMobile ? 16 : -34,
          top: context.isMobile ? -14 : 18,
          child: Container(width: 76, height: 1, color: AppColors.accent),
        ),
      ],
    );
  }
}

class _HeroTitle extends StatelessWidget {
  const _HeroTitle();

  @override
  Widget build(BuildContext context) {
    final style = context.isMobile
        ? Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 39)
        : Theme.of(context).textTheme.displayLarge;
    const title = '毎日に、\n少しだけ特別を。';

    if (context.isMobile) {
      return Text(title, style: style);
    }

    // The explicit newline is the only desktop break. Scale down only when a
    // narrower desktop needs it, rather than allowing the final particle to
    // wrap onto an unintended third line.
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(title, maxLines: 2, softWrap: false, style: style),
    );
  }
}

class _HeroBackground extends StatefulWidget {
  const _HeroBackground();

  @override
  State<_HeroBackground> createState() => _HeroBackgroundState();
}

class _HeroBackgroundState extends State<_HeroBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    );
    _scale = Tween<double>(begin: 1.02, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutSine),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else if (!_controller.isAnimating && !_controller.isCompleted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ScaleTransition(
        scale: _scale,
        child: Image.asset(
          AppAssets.heroBackground,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          excludeFromSemantics: true,
        ),
      ),
    );
  }
}

class _HeroImageEntrance extends StatefulWidget {
  const _HeroImageEntrance({required this.child});

  final Widget child;

  @override
  State<_HeroImageEntrance> createState() => _HeroImageEntranceState();
}

class _HeroImageEntranceState extends State<_HeroImageEntrance> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final visible = _visible || reduceMotion;
    final duration = reduceMotion ? Duration.zero : const Duration(seconds: 2);

    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: duration,
      curve: Curves.easeOutCubic,
      child: AnimatedScale(
        scale: visible ? 1 : 1.03,
        duration: duration,
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

class _VerticalCaption extends StatelessWidget {
  const _VerticalCaption();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white.withValues(alpha: .78),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 11),
      child: const Text(
        'あ\nな\nた\nら\nし\nい\n美\nし\nさ',
        style: TextStyle(
          color: AppColors.taupe,
          fontSize: 10,
          height: 1.45,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
