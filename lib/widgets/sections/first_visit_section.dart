import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../common/section_container.dart';
import '../common/section_heading.dart';

class FirstVisitSection extends StatelessWidget {
  const FirstVisitSection({required this.sectionKey, super.key});
  final GlobalKey sectionKey;

  static const _steps = [
    (Icons.calendar_month_outlined, 'ご予約・ご来院', 'お電話またはフォームからご相談ください。'),
    (Icons.chat_bubble_outline_rounded, 'カウンセリング', 'お悩みや普段の生活について丁寧に伺います。'),
    (Icons.health_and_safety_outlined, '状態確認・施術', 'ご説明のうえ、状態に合わせて施術します。'),
    (Icons.fact_check_outlined, '施術後のご案内', '日常生活で意識したいこともお伝えします。'),
  ];

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: sectionKey,
      backgroundColor: AppColors.primaryDark,
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Colors.white),
        child: Column(
          children: [
            const SectionHeading(
              eyebrow: 'First Visit',
              title: '初めての方にも、安心していただくために',
              description: 'ご来院から施術後まで、一つひとつ丁寧にご案内します。',
              onDark: true,
            ),
            const SizedBox(height: 48),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.isDesktop ? 4 : (context.isTablet ? 2 : 1),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 220,
              ),
              itemCount: _steps.length,
              itemBuilder: (context, index) {
                final step = _steps[index];
                return Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .09),
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(color: Colors.white.withValues(alpha: .16)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(step.$1, color: const Color(0xFF83D7E3), size: 30),
                          Text('STEP ${index + 1}', style: const TextStyle(color: Color(0xFF83D7E3), fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(step.$2, style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      Text(step.$3, style: const TextStyle(color: Color(0xFFD6E8ED), height: 1.7)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
