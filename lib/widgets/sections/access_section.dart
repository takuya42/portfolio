import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../common/clinic_image.dart';
import '../common/section_container.dart';
import '../common/section_heading.dart';

class AccessSection extends StatelessWidget {
  const AccessSection({required this.sectionKey, super.key});
  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    final map = ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: AspectRatio(
        aspectRatio: context.isMobile ? 1.25 : 1.2,
        child: const ClinicImage(
          assetPath: AppAssets.clinic,
          semanticLabel: '〇〇接骨院の外観',
          icon: Icons.home_work_outlined,
          placeholderLabel: 'CLINIC EXTERIOR',
        ),
      ),
    );
    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(eyebrow: 'Access', title: '通いやすい、地域の身近な場所に', align: TextAlign.left),
        const SizedBox(height: 30),
        const _AccessRow(icon: Icons.location_on_outlined, title: '所在地', detail: '〒000-0000\n〇〇県〇〇市〇〇町1-2-3'),
        const _AccessRow(icon: Icons.train_outlined, title: '電車でお越しの方', detail: '〇〇線「〇〇駅」東口から徒歩5分'),
        const _AccessRow(icon: Icons.directions_car_outlined, title: 'お車でお越しの方', detail: '院前に専用駐車場3台分をご用意しています'),
      ],
    );
    return SectionContainer(
      sectionKey: sectionKey,
      child: context.isMobile
          ? Column(children: [info, const SizedBox(height: 34), map])
          : Row(children: [Expanded(child: info), const SizedBox(width: 60), Expanded(child: map)]),
    );
  }
}

class _AccessRow extends StatelessWidget {
  const _AccessRow({required this.icon, required this.title, required this.detail});
  final IconData icon;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(color: AppColors.paleBlue, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppColors.ink, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(detail, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
