import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF123641),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.maxContent),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.horizontalPadding, vertical: 52),
            child: Column(
              children: [
                context.isMobile
                    ? const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_FooterBrand(), SizedBox(height: 34), _FooterLinks()])
                    : const Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_FooterBrand(), _FooterLinks()]),
                const SizedBox(height: 40),
                const Divider(color: Color(0xFF31515A)),
                const SizedBox(height: 24),
                const Text(
                  '当サイトはポートフォリオ用に制作した架空の接骨院サイトです。',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFB4C8CE), fontSize: 13, height: 1.6),
                ),
                const SizedBox(height: 10),
                const Text('© 2026 〇〇接骨院', style: TextStyle(color: Color(0xFF7F9BA3), fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  const _FooterBrand();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.health_and_safety_outlined, color: Color(0xFF73CFDC), size: 34),
            SizedBox(width: 12),
            Text('〇〇接骨院', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w800)),
          ],
        ),
        SizedBox(height: 18),
        Text('〒000-0000 〇〇県〇〇市〇〇町1-2-3', style: TextStyle(color: Color(0xFFB4C8CE), height: 1.8)),
        Text('TEL 000-0000-0000', style: TextStyle(color: Color(0xFFB4C8CE), height: 1.8)),
      ],
    );
  }
}

class _FooterLinks extends StatelessWidget {
  const _FooterLinks();

  @override
  Widget build(BuildContext context) {
    const links = ['当院について', '施術メニュー', '初めての方へ', 'スタッフ紹介', 'アクセス', 'お問い合わせ'];
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 380),
      child: Wrap(
        spacing: 22,
        runSpacing: 16,
        children: links.map((label) => Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600))).toList(),
      ),
    );
  }
}
