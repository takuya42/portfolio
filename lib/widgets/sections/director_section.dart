import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../common/clinic_image.dart';
import '../common/section_container.dart';
import '../common/section_heading.dart';

class DirectorSection extends StatelessWidget {
  const DirectorSection({required this.sectionKey, super.key});
  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AspectRatio(
        aspectRatio: context.isMobile ? 1.1 : .92,
        child: const ClinicImage(
          assetPath: AppAssets.director,
          semanticLabel: '院長 山田太郎のプロフィール写真',
          icon: Icons.person_outline_rounded,
          placeholderLabel: 'DIRECTOR',
        ),
      ),
    );
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          eyebrow: 'Director',
          title: '地域の皆さまが、\n毎日を笑顔で過ごせるように',
          align: TextAlign.left,
        ),
        const SizedBox(height: 24),
        Text(
          '身体のお悩みは、同じように見えても生活環境や原因が一人ひとり異なります。〇〇接骨院では、お話を丁寧に伺い、納得して施術を受けていただけるよう心がけています。',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 18),
        const Text('小さなお悩みでも、どうぞお気軽にご相談ください。', style: TextStyle(color: AppColors.body, fontSize: 16, height: 1.8)),
        const SizedBox(height: 26),
        const Row(
          children: [
            Text('院長', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
            SizedBox(width: 14),
            Text('山田 太郎', style: TextStyle(color: AppColors.ink, fontSize: 23, fontWeight: FontWeight.w800, letterSpacing: 2)),
          ],
        ),
        const SizedBox(height: 8),
        const Text('柔道整復師（ダミー情報）', style: TextStyle(color: AppColors.body)),
      ],
    );

    return SectionContainer(
      sectionKey: sectionKey,
      child: context.isMobile
          ? Column(children: [image, const SizedBox(height: 38), copy])
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Expanded(flex: 8, child: image), const SizedBox(width: 70), Expanded(flex: 10, child: copy)],
            ),
    );
  }
}
