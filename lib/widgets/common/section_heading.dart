import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    required this.eyebrow,
    required this.title,
    super.key,
    this.description,
    this.align = TextAlign.center,
    this.onDark = false,
  });

  final String eyebrow;
  final String title;
  final String? description;
  final TextAlign align;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final crossAxisAlignment = align == TextAlign.center
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          eyebrow.toUpperCase(),
          textAlign: align,
          style: TextStyle(
            color: onDark ? AppColors.sand : AppColors.accent,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          textAlign: align,
          style: context.isMobile
              ? Theme.of(context).textTheme.headlineMedium?.copyWith(color: onDark ? Colors.white : AppColors.charcoal)
              : Theme.of(context).textTheme.headlineLarge?.copyWith(color: onDark ? Colors.white : AppColors.charcoal),
        ),
        if (description != null) ...[
          const SizedBox(height: 18),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              description!,
              textAlign: align,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: onDark ? AppColors.sand : AppColors.body),
            ),
          ),
        ],
      ],
    );
  }
}
