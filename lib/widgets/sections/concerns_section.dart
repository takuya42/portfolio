import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../common/section_container.dart';
import '../common/section_heading.dart';
import '../common/motion.dart';

class ConcernsSection extends StatelessWidget {
  const ConcernsSection({required this.sectionKey, super.key});
  final GlobalKey sectionKey;

  static const _concerns = [
    (Icons.airline_seat_recline_extra_rounded, '肩・首がつらい'),
    (Icons.accessibility_new_rounded, '腰に違和感がある'),
    (Icons.directions_run_rounded, 'スポーツでケガをした'),
    (Icons.balance_rounded, '姿勢が気になる'),
  ];

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: sectionKey,
      child: Column(
        children: [
          const SectionHeading(
            eyebrow: 'Concerns',
            title: 'このようなお悩みはありませんか？',
            description: '日常生活の小さな違和感から、スポーツによる身体のお悩みまで。どうぞお気軽にご相談ください。',
          ),
          const SizedBox(height: 44),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.isDesktop ? 4 : (context.isTablet ? 2 : 1),
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              mainAxisExtent: context.isMobile ? 96 : 128,
            ),
            itemCount: _concerns.length,
            itemBuilder: (context, index) {
              final concern = _concerns[index];
              return RevealOnScroll(delay: Duration(milliseconds: index * 70), child: HoverLift(child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.softBlue,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.white,
                      child: Icon(concern.$1, color: AppColors.primary),
                    ),
                    const SizedBox(width: 14),
                    Expanded(child: Text(concern.$2, style: const TextStyle(color: AppColors.ink, fontWeight: FontWeight.w700, fontSize: 16))),
                  ],
                ),
              )));
            },
          ),
        ],
      ),
    );
  }
}
