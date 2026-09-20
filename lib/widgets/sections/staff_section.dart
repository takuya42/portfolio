import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../../core/salon_data.dart';
import '../common/motion.dart';
import '../common/salon_image.dart';
import '../common/section_container.dart';
import '../common/section_heading.dart';

class StaffSection extends StatelessWidget {
  const StaffSection({required this.sectionKey, super.key});

  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: sectionKey,
      backgroundColor: AppColors.ivory,
      child: Column(
        children: [
          const SectionHeading(
            eyebrow: 'STAFF',
            title: '髪と、心に寄り添う人。',
          ),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: SalonData.staff.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.isMobile
                  ? 1
                  : context.isTablet
                  ? 2
                  : 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 32,
              childAspectRatio: context.isMobile ? 1.05 : .66,
            ),
            itemBuilder: (context, index) {
              final staff = SalonData.staff[index];

              return HoverLift(
                borderRadius: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SalonImage(
                        assetPath: AppAssets.staff[index],
                        semanticLabel: '${staff.name}のプロフィール写真',
                        label: 'PORTRAIT',
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      staff.role.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontSize: 10,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      staff.name,
                      style: const TextStyle(fontSize: 19, letterSpacing: 1),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      staff.bio,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
