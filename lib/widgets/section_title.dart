import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';

/// Har section ka heading: chhota eyebrow, bada title, gold line, subtitle.
class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.eyebrow,
    this.subtitle,
    this.onDark = false,
  });

  final String title;
  final String? eyebrow;
  final String? subtitle;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final t = context.text;

    return Column(
      children: [
        if (eyebrow != null) ...[
          Text(eyebrow!.toUpperCase(), style: t.eyebrow),
          const SizedBox(height: AppTheme.sm),
        ],
        Text(
          title,
          textAlign: TextAlign.center,
          style: t.sectionTitle.copyWith(
            color: onDark ? AppColors.white : AppColors.navy,
          ),
        ),
        const SizedBox(height: AppTheme.sm),
        // Gold underline
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            gradient: AppColors.goldGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppTheme.md),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: t.sectionSubtitle.copyWith(
                color: onDark ? AppColors.textOnDarkMuted : AppColors.textMuted,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
