import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

/// 実画像とコード製プレースホルダーを同じレイアウトで表示します。
///
/// [assetPath] が `null` の間はプレースホルダーを表示し、画像を用意した
/// あとは `AppAssets` のパスを設定するだけで [Image.asset] に切り替わります。
class ClinicImage extends StatelessWidget {
  const ClinicImage({
    required this.assetPath,
    required this.semanticLabel,
    required this.icon,
    super.key,
    this.placeholderLabel = 'IMAGE',
    this.fit = BoxFit.cover,
  });

  final String? assetPath;
  final String semanticLabel;
  final IconData icon;
  final String placeholderLabel;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final path = assetPath;
    if (path != null) {
      return Image.asset(
        path,
        fit: fit,
        semanticLabel: semanticLabel,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return Semantics(
      image: true,
      label: '$semanticLabel（仮画像）',
      child: ExcludeSemantics(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF2FBFC), Color(0xFFD5EEF2)],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const Positioned(
                top: -40,
                right: -30,
                child: _DecorativeCircle(size: 180, color: Colors.white),
              ),
              const Positioned(
                bottom: -65,
                left: -50,
                child: _DecorativeCircle(
                  size: 220,
                  color: AppColors.secondary,
                  opacity: .12,
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .86),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                      ),
                      child: Icon(icon, size: 36, color: AppColors.primary),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      placeholderLabel,
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.4,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '画像を配置予定',
                      style: TextStyle(color: AppColors.body, fontSize: 13),
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

class _DecorativeCircle extends StatelessWidget {
  const _DecorativeCircle({
    required this.size,
    required this.color,
    this.opacity = .52,
  });

  final double size;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}
