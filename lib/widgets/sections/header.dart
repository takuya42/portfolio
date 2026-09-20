import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';

const _navItems = <(String, String)>[
  ('当院について', 'about'),
  ('施術メニュー', 'services'),
  ('初めての方へ', 'first'),
  ('スタッフ紹介', 'staff'),
  ('アクセス', 'access'),
];

class Header extends StatelessWidget {
  const Header({
    required this.onMenuPressed,
    required this.onNavigate,
    super.key,
  });

  final VoidCallback onMenuPressed;
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: Colors.white.withValues(alpha: .97),
      surfaceTintColor: Colors.transparent,
      shadowColor: const Color(0x1A123C49),
      elevation: 1,
      toolbarHeight: context.isMobile ? 70 : 82,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.maxContent),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.horizontalPadding),
            child: Row(
              children: [
                const _ClinicLogo(),
                const Spacer(),
                if (context.isDesktop) ...[
                  for (final item in _navItems)
                    TextButton(
                      onPressed: () => onNavigate(item.$2),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.ink,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                      ),
                      child: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  const SizedBox(width: 10),
                  FilledButton.icon(
                    onPressed: () => onNavigate('contact'),
                    icon: const Icon(Icons.mail_outline_rounded, size: 19),
                    label: const Text('お問い合わせ'),
                  ),
                ] else
                  IconButton(
                    tooltip: 'メニューを開く',
                    onPressed: onMenuPressed,
                    icon: const Icon(Icons.menu_rounded, size: 30),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ClinicLogo extends StatelessWidget {
  const _ClinicLogo();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      label: '〇〇接骨院 ホーム',
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(Icons.health_and_safety_outlined, color: Colors.white, size: 25),
          ),
          const SizedBox(width: 11),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('〇〇接骨院', style: TextStyle(color: AppColors.ink, fontSize: 20, fontWeight: FontWeight.w800)),
              Text('MARUMARU CLINIC', style: TextStyle(color: AppColors.primary, fontSize: 8, letterSpacing: 1.5, fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }
}

class ClinicDrawer extends StatelessWidget {
  const ClinicDrawer({required this.onNavigate, super.key});

  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(24, 28, 24, 18),
          child: _ClinicLogo(),
        ),
        const Divider(height: 1),
        const SizedBox(height: 12),
        for (final item in _navItems)
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
            title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => onNavigate(item.$2),
          ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: FilledButton.icon(
            onPressed: () => onNavigate('contact'),
            icon: const Icon(Icons.mail_outline_rounded),
            label: const Text('お問い合わせ'),
          ),
        ),
      ],
    );
  }
}
