import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_counter.dart';
import '../widgets/fade_in.dart';
import '../widgets/section_wrapper.dart';

/// Navy band with counters jo scroll par 0 se ginte hain.
class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.text;
    final isMobile = context.isMobile;

    return SectionWrapper(
      gradient: AppColors.heroGradient,
      verticalPadding: isMobile ? AppTheme.xl : AppTheme.xxl,
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: AppTheme.xl,
        runSpacing: AppTheme.xl,
        children: [
          for (var i = 0; i < MockData.stats.length; i++)
            FadeIn(
              delay: i * 120,
              child: SizedBox(
                width: isMobile ? 130 : 190,
                child: Column(
                  children: [
                    AnimatedCounter(
                      value: MockData.stats[i].value,
                      suffix: MockData.stats[i].suffix,
                      style: t.stat,
                    ),
                    const SizedBox(height: AppTheme.xs),
                    Text(
                      MockData.stats[i].label,
                      textAlign: TextAlign.center,
                      style: t.caption.copyWith(
                        color: AppColors.textOnDarkMuted,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
