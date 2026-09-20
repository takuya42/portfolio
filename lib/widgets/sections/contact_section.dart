import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../common/section_container.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({required this.sectionKey, super.key});
  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: sectionKey,
      backgroundColor: AppColors.paleBlue,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: context.isMobile ? 22 : 60, vertical: context.isMobile ? 44 : 58),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFF159CB9)]),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          children: [
            const Icon(Icons.waving_hand_outlined, color: Color(0xFFBDEBF1), size: 34),
            const SizedBox(height: 16),
            Text(
              '身体のお悩みを、\nまずはお気軽にご相談ください',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: context.isMobile ? 27 : 34, fontWeight: FontWeight.w800, height: 1.45),
            ),
            const SizedBox(height: 14),
            const Text('ご相談だけでも大丈夫です。スタッフが丁寧にお話を伺います。', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFE4F5F8), fontSize: 16, height: 1.7)),
            const SizedBox(height: 28),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 14,
              runSpacing: 14,
              children: [
                FilledButton.icon(
                  onPressed: () {},
                  style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.primaryDark),
                  icon: const Icon(Icons.phone_outlined),
                  label: const Text('000-0000-0000'),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white)),
                  icon: const Icon(Icons.mail_outline_rounded),
                  label: const Text('フォームでお問い合わせ'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('電話受付：平日 9:00〜19:30／土曜 9:00〜17:00', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFD3EFF3), fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
