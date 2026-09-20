import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../common/info_card.dart';
import '../common/section_container.dart';
import '../common/section_heading.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  static const _features = [
    (Icons.forum_outlined, '丁寧なカウンセリング', 'お悩みや生活習慣を丁寧に伺い、一人ひとりに合わせた施術方針をご提案します。'),
    (Icons.record_voice_over_outlined, '分かりやすいご説明', '専門用語をできるだけ使わず、身体の状態や施術内容を分かりやすくお伝えします。'),
    (Icons.home_work_outlined, '通いやすい環境', '平日は夜まで、土曜日も受付。明るく清潔な院内で安心してお過ごしいただけます。'),
  ];

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      backgroundColor: AppColors.softBlue,
      child: Column(
        children: [
          const SectionHeading(eyebrow: 'Our Values', title: '〇〇接骨院が大切にしていること'),
          const SizedBox(height: 46),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.isDesktop ? 3 : (context.isTablet ? 2 : 1),
              crossAxisSpacing: 22,
              mainAxisSpacing: 22,
              mainAxisExtent: 265,
            ),
            itemCount: _features.length,
            itemBuilder: (context, index) {
              final feature = _features[index];
              return InfoCard(icon: feature.$1, title: feature.$2, description: feature.$3, number: '0${index + 1}');
            },
          ),
        ],
      ),
    );
  }
}
