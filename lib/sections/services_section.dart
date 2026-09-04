import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../screens/service_detail_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';
import '../widgets/fade_in.dart';
import '../widgets/hover_card.dart';
import '../widgets/section_title.dart';
import '../widgets/section_wrapper.dart';

/// Services ka responsive grid. Card par tap karo to detail screen khulti hai.
class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  /// Screen width ke hisaab se columns.
  int _columns(BuildContext context) {
    final w = context.screenWidth;
    if (w < 700) return 1;
    if (w < 1050) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    final columns = _columns(context);

    return SectionWrapper(
      background: AppColors.white,
      child: Column(
        children: [
          const SectionTitle(
            eyebrow: 'What we do',
            title: 'Our Services',
            subtitle:
                'Advisory, compliance and litigation support across every area '
                'a growing business or family actually runs into.',
          ),
          const SizedBox(height: AppTheme.xxl),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: MockData.services.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: AppTheme.lg,
              crossAxisSpacing: AppTheme.lg,
              mainAxisExtent: 210,
            ),
            itemBuilder: (context, i) {
              final service = MockData.services[i];
              return FadeIn(
                // Row ke hisaab se stagger - poori row ek saath aati hai.
                delay: (i ~/ columns) * 110,
                child: _ServiceCard(service: service),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    final t = context.text;

    return HoverCard(
      lift: 12,
      onTap: () => Navigator.of(context).push(
        // Detail screen slide + fade hoke aati hai.
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 420),
          pageBuilder: (_, __, ___) => ServiceDetailScreen(service: service),
          transitionsBuilder: (_, animation, __, child) {
            final curved =
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0, 0.06),
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.lg),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppTheme.radius),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon aur price ek hi line mein - neeche wali row mein dono
            // rakhne se narrow cards par overflow ho jaata tha.
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      Icon(service.icon, size: 22, color: AppColors.goldDark),
                ),
                const Spacer(),
                if (service.startingPrice != null)
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        service.startingPrice!,
                        style: t.caption.copyWith(fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppTheme.md),
            Text(service.title, style: t.cardTitle, maxLines: 1,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: AppTheme.xs),
            Expanded(
              child: Text(
                service.summary,
                style: t.cardBody,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: AppTheme.xs),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Learn more',
                  style: t.caption.copyWith(
                    color: AppColors.goldDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward_rounded,
                    size: 13, color: AppColors.goldDark),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
