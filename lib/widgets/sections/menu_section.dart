import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/salon_data.dart';
import '../common/motion.dart';
import '../common/section_container.dart';
import '../common/section_heading.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({required this.sectionKey, super.key});

  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: sectionKey,
      backgroundColor: AppColors.ivory,
      child: Column(
        children: [
          const SectionHeading(
            eyebrow: 'MENU',
            title: '美しさを整える、シンプルなメニュー',
            description: 'すべて税込価格です。髪の長さやデザインにより料金が異なる場合があります。',
          ),
          const SizedBox(height: 54),
          Container(
            constraints: const BoxConstraints(maxWidth: 850),
            child: Column(
              children: [
                for (final (index, item) in SalonData.menu.indexed)
                  RevealOnScroll(
                    delay: Duration(milliseconds: index * 70),
                    child: HoverLift(
                      borderRadius: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 10,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.border),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                item.detail,
                                style: const TextStyle(color: AppColors.body),
                              ),
                            ),
                            Text(
                              item.price,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            '※ カウンセリング後にメニュー内容と料金をご案内します。',
            style: TextStyle(fontSize: 12, color: AppColors.greige),
          ),
        ],
      ),
    );
  }
}
