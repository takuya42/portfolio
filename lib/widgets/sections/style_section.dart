import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../../core/style_data.dart';
import '../common/motion.dart';
import '../common/salon_image.dart';
import '../common/section_container.dart';

class StyleSection extends StatelessWidget {
  const StyleSection({required this.sectionKey, super.key});

  final GlobalKey sectionKey;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      sectionKey: sectionKey,
      backgroundColor: AppColors.ivory,
      child: Column(
        children: [
          const RevealOnScroll(child: _StyleHeading()),
          const SizedBox(height: 20),
          const RevealOnScroll(
            delay: Duration(milliseconds: 100),
            child: Text(
              '一人ひとりの雰囲気やライフスタイルに合わせた\nヘアデザインをご提案します。',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.body,
                fontSize: 14,
                height: 2,
                letterSpacing: .7,
              ),
            ),
          ),
          SizedBox(height: context.isMobile ? 44 : 72),
          _StyleGallery(styles: StyleData.styles),
          SizedBox(height: context.isMobile ? 48 : 72),
          const RevealOnScroll(
            delay: Duration(milliseconds: 620),
            child: _ViewAllLabel(),
          ),
        ],
      ),
    );
  }
}

class _StyleHeading extends StatelessWidget {
  const _StyleHeading();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'STYLE',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.charcoal,
                fontSize: context.isMobile ? 35 : 48,
                fontWeight: FontWeight.w400,
                letterSpacing: 7,
              ),
        ),
        const SizedBox(height: 11),
        const Text(
          'ヘアスタイル',
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 11,
            letterSpacing: 2.4,
          ),
        ),
      ],
    );
  }
}

class _StyleGallery extends StatelessWidget {
  const _StyleGallery({required this.styles});

  final List<HairStyle> styles;

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      if (context.screenWidth < 360) {
        return _StyleColumn(styles: styles);
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _StyleColumn(styles: [styles[0], styles[3], styles[4]]),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _StyleColumn(
              styles: [styles[1], styles[2], styles[5]],
              offset: true,
            ),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 10,
          child: _StyleColumn(styles: [styles[0], styles[3]]),
        ),
        const SizedBox(width: 28),
        Expanded(
          flex: 9,
          child: _StyleColumn(styles: [styles[1], styles[4]], offset: true),
        ),
        const SizedBox(width: 28),
        Expanded(
          flex: 11,
          child: _StyleColumn(styles: [styles[2], styles[5]]),
        ),
      ],
    );
  }
}

class _StyleColumn extends StatelessWidget {
  const _StyleColumn({required this.styles, this.offset = false});

  final List<HairStyle> styles;
  final bool offset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: offset ? (context.isMobile ? 34 : 76) : 0),
      child: Column(
        children: [
          for (var index = 0; index < styles.length; index++) ...[
            RevealOnScroll(
              delay: Duration(
                milliseconds: 180 +
                    StyleData.styles.indexOf(styles[index]) * 85,
              ),
              child: _StyleCard(
                style: styles[index],
                aspectRatio: _aspectRatio(styles[index].number),
              ),
            ),
            if (index != styles.length - 1)
              SizedBox(height: context.isMobile ? 30 : 48),
          ],
        ],
      ),
    );
  }

  double _aspectRatio(String number) => switch (number) {
        '01' || '05' => .68,
        '03' || '04' => 1.05,
        _ => .82,
      };
}

class _StyleCard extends StatelessWidget {
  const _StyleCard({required this.style, required this.aspectRatio});

  final HairStyle style;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: aspectRatio,
          child: HoverMedia(
            overlay: _StyleOverlay(style: style),
            child: SalonImage(
              assetPath: style.assetPath,
              semanticLabel: '${style.name} / ${style.japaneseName}',
              label: 'STYLE ${style.number}',
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              style.number,
              style: const TextStyle(
                color: AppColors.accent,
                fontSize: 10,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    style.name,
                    style: const TextStyle(
                      color: AppColors.charcoal,
                      fontSize: 13,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    style.japaneseName,
                    style: const TextStyle(
                      color: AppColors.taupe,
                      fontSize: 10,
                      letterSpacing: .8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StyleOverlay extends StatelessWidget {
  const _StyleOverlay({required this.style});

  final HairStyle style;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Text(
          style.name.toUpperCase(),
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 2.2,
          ),
        ),
      ),
    );
  }
}

class _ViewAllLabel extends StatelessWidget {
  const _ViewAllLabel();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'すべてのスタイルを見る。スタイルページは準備中です',
      child: Container(
        padding: const EdgeInsets.only(bottom: 11),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.charcoal)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VIEW ALL STYLES',
                  style: TextStyle(
                    color: AppColors.charcoal,
                    fontSize: 11,
                    letterSpacing: 2.2,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'すべてのスタイルを見る',
                  style: TextStyle(color: AppColors.taupe, fontSize: 10),
                ),
              ],
            ),
            SizedBox(width: 30),
            Icon(Icons.arrow_forward, size: 17, color: AppColors.charcoal),
          ],
        ),
      ),
    );
  }
}
