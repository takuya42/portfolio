import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/responsive.dart';
import '../common/motion.dart';
import '../common/salon_image.dart';
import '../common/section_container.dart';
import '../common/section_heading.dart';

class StyleSection extends StatelessWidget {
  const StyleSection({required this.sectionKey, super.key});

  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    final columns = context.isMobile ? 2 : 3;

    return SectionContainer(
      sectionKey: sectionKey,
      child: Column(
        children: [
          const SectionHeading(
            eyebrow: 'STYLE',
            title: 'Find your style.',
            description: '日常になじむ、さりげなく今っぽいスタイル。',
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: context.isMobile ? 10 : 20,
              mainAxisSpacing: context.isMobile ? 10 : 20,
              childAspectRatio: _getImageAspectRatio(context),
            ),
            itemBuilder: (context, index) => RevealOnScroll(
              delay: Duration(milliseconds: index * 80),
              child: HoverMedia(
                child: SalonImage(
                  assetPath: AppAssets.styles[index],
                  semanticLabel: 'ヘアスタイル ${index + 1}',
                  label: 'STYLE 0${index + 1}',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getImageAspectRatio(BuildContext context) {
    return context.isMobile ? .72 : .8;
  }
}
