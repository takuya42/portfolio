import 'package:flutter/material.dart';

import '../../core/responsive.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    required this.child,
    super.key,
    this.backgroundColor = Colors.white,
    this.padding,
    this.sectionKey,
  });

  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final GlobalKey? sectionKey;

  @override
  Widget build(BuildContext context) {
    final vertical = context.isMobile ? 72.0 : 104.0;
    return ColoredBox(
      key: sectionKey,
      color: backgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.maxContent),
          child: Padding(
            padding: padding ?? EdgeInsets.symmetric(
              horizontal: context.horizontalPadding,
              vertical: vertical,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
