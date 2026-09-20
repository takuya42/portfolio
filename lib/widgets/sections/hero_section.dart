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
    return SectionContainer(
      backgroundColor: AppColors.ivory,
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
                Expanded(flex: 8, child: _buildCopy(context)),
                const SizedBox(width: 60),
                Expanded(flex: 10, child: _buildVisual(context)),
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
        RevealOnScroll(
          delay: const Duration(milliseconds: 100),
          child: Text(
            '毎日に、\n少しだけ特別を。',
            style: context.isMobile
                ? Theme.of(
                    context,
                  ).textTheme.displayLarge?.copyWith(fontSize: 39)
                : Theme.of(context).textTheme.displayLarge,
          ),
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
          aspectRatio: context.isMobile ? .82 : 1.12,
          child: const SalonImage(
            assetPath: AppAssets.hero,
            semanticLabel: 'サロンのメインビジュアル',
            label: 'HERO PHOTO',
          ),
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
      ],
    );
  }
}
