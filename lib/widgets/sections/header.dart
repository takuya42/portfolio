import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../../core/salon_data.dart';

const navItems = <(String, String)>[
  ('HOME', 'home'),
  ('CONCEPT', 'concept'),
  ('MENU', 'menu'),
  ('STYLE', 'style'),
  ('STAFF', 'staff'),
  ('ACCESS', 'access'),
  ('CONTACT', 'contact'),
];

class Header extends StatefulWidget {
  const Header({
    required this.onMenuPressed,
    required this.onNavigate,
    required this.scrollController,
    super.key,
  });

  final VoidCallback onMenuPressed;
  final ValueChanged<String> onNavigate;
  final ScrollController scrollController;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateScrollState);
  }

  void _updateScrollState() {
    final isScrolled =
        widget.scrollController.hasClients &&
        widget.scrollController.offset > 30;

    if (isScrolled != _isScrolled) {
      setState(() => _isScrolled = isScrolled);
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateScrollState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: context.isMobile ? 68 : 82,
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      shadowColor: const Color(0x18292724),
      elevation: _isScrolled ? 3 : 0,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: _isScrolled ? 12 : 4,
            sigmaY: _isScrolled ? 12 : 4,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: _isScrolled
                ? AppColors.white.withValues(alpha: .88)
                : AppColors.ivory.withValues(alpha: .72),
          ),
        ),
      ),
      title: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.maxContent),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.horizontalPadding),
            child: Row(
              children: [
                _Logo(onTap: () => widget.onNavigate('home')),
                const Spacer(),
                if (context.isDesktop) ...[
                  for (final item in navItems.skip(1))
                    _NavigationLink(
                      label: item.$1,
                      onTap: () => widget.onNavigate(item.$2),
                    ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: () => widget.onNavigate('contact'),
                    child: const Text('RESERVATION'),
                  ),
                ] else
                  IconButton(
                    onPressed: widget.onMenuPressed,
                    tooltip: 'メニューを開く',
                    icon: const Icon(Icons.menu_rounded, size: 29),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationLink extends StatefulWidget {
  const _NavigationLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavigationLink> createState() => _NavigationLinkState();
}

class _NavigationLinkState extends State<_NavigationLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: TextButton(
        onPressed: widget.onTap,
        style: TextButton.styleFrom(
          foregroundColor: _hovered ? AppColors.accent : AppColors.charcoal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: const TextStyle(fontSize: 11, letterSpacing: 1.3),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              width: _hovered ? 22 : 0,
              height: 1,
              color: AppColors.accent,
            ),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            SalonData.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 2.2,
              color: AppColors.charcoal,
            ),
          ),
          Text(
            'HAIR & LIFESTYLE',
            style: TextStyle(
              fontSize: 8,
              letterSpacing: 2.4,
              color: AppColors.taupe,
            ),
          ),
        ],
      ),
    );
  }
}

class SalonDrawer extends StatelessWidget {
  const SalonDrawer({required this.onNavigate, super.key});

  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      backgroundColor: AppColors.ivory,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 32, 24, 20),
          child: _Logo(),
        ),
        const Divider(),
        for (final item in navItems)
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 4,
            ),
            title: Text(
              item.$1,
              style: const TextStyle(letterSpacing: 1.8, fontSize: 13),
            ),
            onTap: () => onNavigate(item.$2),
          ),
        Padding(
          padding: const EdgeInsets.all(28),
          child: FilledButton(
            onPressed: () => onNavigate('contact'),
            child: const Text('WEB RESERVATION'),
          ),
        ),
      ],
    );
  }
}
