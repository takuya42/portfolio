import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../common/section_container.dart';
import '../common/section_heading.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({required this.sectionKey, super.key});
  final GlobalKey sectionKey;

  static const _services = [
    (Icons.self_improvement_rounded, '肩・首のお悩み', 'デスクワークや日々の生活による肩・首まわりのお悩みに。'),
    (Icons.accessibility_new_rounded, '腰のお悩み', '姿勢や身体の使い方を確認し、健やかな毎日を支えます。'),
    (Icons.directions_run_rounded, 'スポーツによるケガ', '捻挫・打撲など、スポーツ時の身体のお悩みをサポート。'),
    (Icons.balance_rounded, '姿勢・骨盤ケア', '身体全体のバランスや日常の姿勢が気になる方へ。'),
    (Icons.healing_outlined, '手技による施術', '身体の状態を確認しながら、無理のない丁寧な施術を行います。'),
    (Icons.directions_car_outlined, '交通事故後のご相談', '事故後の身体や通院について、まずはお気軽にご相談ください。'),
  ];

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: sectionKey,
      child: Column(
        children: [
          const SectionHeading(
            eyebrow: 'Services',
            title: 'お悩みに合わせた施術メニュー',
            description: '身体の状態を丁寧に確認し、一人ひとりに合った施術をご提案します。',
          ),
          const SizedBox(height: 46),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.isDesktop ? 3 : (context.isTablet ? 2 : 1),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: 225,
            ),
            itemCount: _services.length,
            itemBuilder: (context, index) {
              final service = _services[index];
              return _ServiceCard(icon: service.$1, title: service.$2, description: service.$3);
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.icon, required this.title, required this.description});
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: const BorderSide(color: AppColors.border)),
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 34),
            const SizedBox(height: 18),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(description, maxLines: 3, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
