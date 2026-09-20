import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../common/clinic_image.dart';
import '../common/section_container.dart';
import '../common/motion.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({required this.onContactTap, super.key});

  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      backgroundColor: AppColors.softBlue,
      padding: EdgeInsets.fromLTRB(
        context.horizontalPadding,
        context.isMobile ? 36 : 64,
        context.horizontalPadding,
        context.isMobile ? 56 : 76,
      ),
      child: context.isMobile
          ? Column(children: [_copy(context), const SizedBox(height: 36), _visual(context)])
          : Row(
              children: [
                Expanded(flex: 10, child: _copy(context)),
                const SizedBox(width: 48),
                Expanded(flex: 9, child: _visual(context)),
              ],
            ),
    );
  }

  Widget _copy(BuildContext context) {
    final headlineStyle = context.isMobile
        ? Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 34)
        : Theme.of(context).textTheme.displayLarge;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealOnScroll(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(color: AppColors.paleBlue, borderRadius: BorderRadius.circular(30)),
            child: const Text(
              '地域に寄り添う、身近な接骨院',
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
        ),
        const SizedBox(height: 22),
        RevealOnScroll(delay: const Duration(milliseconds: 100), child: Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: '地域の皆さまの\n'),
              TextSpan(text: '健やかな毎日', style: headlineStyle?.copyWith(color: AppColors.primary)),
              const TextSpan(text: 'を支える'),
            ],
          ),
          style: headlineStyle,
        )),
        const SizedBox(height: 20),
        RevealOnScroll(delay: const Duration(milliseconds: 220), child: Text(
          '肩こり・腰痛・スポーツによる身体のお悩みに。\n一人ひとりに寄り添い、丁寧な施術でサポートします。',
          style: Theme.of(context).textTheme.bodyLarge,
        )),
        const SizedBox(height: 28),
        RevealOnScroll(delay: const Duration(milliseconds: 340), child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            HoverLift(borderRadius: 12, child: FilledButton.icon(
              onPressed: onContactTap,
              icon: const Icon(Icons.calendar_month_outlined),
              label: const Text('ご予約・お問い合わせ'),
            )),
            HoverLift(borderRadius: 12, child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.phone_outlined),
              label: const Text('000-0000-0000'),
            )),
          ],
        )),
        const SizedBox(height: 26),
        const Wrap(
          spacing: 20,
          runSpacing: 10,
          children: [
            _HeroFact(icon: Icons.train_rounded, text: '〇〇駅 徒歩5分'),
            _HeroFact(icon: Icons.schedule_rounded, text: '平日19:30まで'),
            _HeroFact(icon: Icons.event_available_rounded, text: '土曜も受付'),
          ],
        ),
      ],
    );
  }

  Widget _visual(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AspectRatio(
          aspectRatio: context.isMobile ? 1.15 : .92,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: const ClinicImage(
              assetPath: AppAssets.hero,
              semanticLabel: '施術について説明するスタッフのイメージ',
              icon: Icons.health_and_safety_outlined,
              placeholderLabel: 'CLINIC CARE',
            ),
          ),
        ),
        Positioned(
          left: context.isMobile ? 12 : -26,
          bottom: context.isMobile ? -18 : 24,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [BoxShadow(color: Color(0x24123C49), blurRadius: 24, offset: Offset(0, 8))],
            ),
            child: const Row(
              children: [
                CircleAvatar(backgroundColor: AppColors.paleBlue, child: Icon(Icons.favorite_outline, color: AppColors.primary)),
                SizedBox(width: 12),
                Text('丁寧な対話を\n大切にしています', style: TextStyle(color: AppColors.ink, fontWeight: FontWeight.w700, height: 1.5)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroFact extends StatelessWidget {
  const _HeroFact({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: AppColors.ink, fontWeight: FontWeight.w600)),
        ],
      );
}
