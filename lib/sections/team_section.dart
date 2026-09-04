import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';
import '../widgets/fade_in.dart';
import '../widgets/hover_card.dart';
import '../widgets/section_title.dart';
import '../widgets/section_wrapper.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return SectionWrapper(
      background: AppColors.surface,
      child: Column(
        children: [
          const SectionTitle(
            eyebrow: 'Our people',
            title: 'Legal Team',
            subtitle:
                'The advocates who will actually handle your matter - not a '
                'call centre.',
          ),
          const SizedBox(height: AppTheme.xxl),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppTheme.lg,
            runSpacing: AppTheme.lg,
            children: [
              for (var i = 0; i < MockData.team.length; i++)
                FadeIn(
                  delay: i * 100,
                  child: SizedBox(
                    width: isMobile ? 260 : 250,
                    child: _TeamCard(member: MockData.team[i]),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TeamCard extends StatelessWidget {
  const _TeamCard({required this.member});

  final TeamMember member;

  @override
  Widget build(BuildContext context) {
    final t = context.text;

    return HoverCard(
      lift: 8,
      scale: 1.02,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.lg),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppTheme.radius),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            // Photo ki jagah initials - abhi koi asset nahi chahiye.
            Container(
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                gradient: AppColors.heroGradient,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.gold, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                member.initials,
                style: t.cardTitle.copyWith(
                  color: AppColors.goldLight,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.md),
            Text(member.name, style: t.cardTitle, textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text(
              member.role,
              style: t.caption.copyWith(
                color: AppColors.goldDark,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.sm),
            Divider(color: AppColors.border, height: AppTheme.md),
            Text(
              member.expertise,
              style: t.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppTheme.xs),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                member.experience,
                style: t.caption.copyWith(
                  color: AppColors.goldDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
