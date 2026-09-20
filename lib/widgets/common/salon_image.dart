import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class SalonImage extends StatelessWidget {
  const SalonImage({
    required this.assetPath,
    required this.semanticLabel,
    super.key,
    this.label = 'SALON IMAGE',
    this.fit = BoxFit.cover,
  });

  final String? assetPath;
  final String semanticLabel;
  final String label;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (assetPath case final path?) {
      return Image.asset(
        path,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
        semanticLabel: semanticLabel,
      );
    }

    return Semantics(
      image: true,
      label: '$semanticLabel（写真プレースホルダー）',
      child: ExcludeSemantics(
        child: ColoredBox(
          color: AppColors.sand,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: -50,
                bottom: -70,
                child: Container(
                  width: 210,
                  height: 210,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: .34),
                  ),
                ),
              ),
              Positioned(
                right: -20,
                top: -35,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.greige.withValues(alpha: .18),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add_rounded,
                      color: AppColors.taupe,
                      size: 30,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      label,
                      style: const TextStyle(
                        color: AppColors.taupe,
                        fontSize: 11,
                        letterSpacing: 2.6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'PHOTO PLACEHOLDER',
                      style: TextStyle(
                        color: AppColors.greige,
                        fontSize: 9,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
