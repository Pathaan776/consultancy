import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';
import '../widgets/fade_in.dart';
import '../widgets/gold_button.dart';

/// Ek service ki detail screen. Card se slide + fade hoke khulti hai.
class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key, required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    final t = context.text;
    final isMobile = context.isMobile;

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: CustomScrollView(
        slivers: [
          // Scroll par collapse hone wala navy header.
          SliverAppBar(
            expandedHeight: isMobile ? 240 : 300,
            pinned: true,
            backgroundColor: AppColors.navy,
            iconTheme: const IconThemeData(color: AppColors.white),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 56,
                vertical: AppTheme.md,
              ),
              title: Text(
                service.title,
                style: t.cardTitle.copyWith(color: AppColors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  const DecoratedBox(
                    decoration: BoxDecoration(gradient: AppColors.heroGradient),
                  ),
                  Align(
                    alignment: const Alignment(0, -0.25),
                    child: Icon(
                      service.icon,
                      size: 76,
                      color: AppColors.gold.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Padding(
                  padding: EdgeInsets.all(
                    isMobile ? AppTheme.md : AppTheme.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeIn(
                        child: Text(service.description, style: t.bodyLarge),
                      ),
                      const SizedBox(height: AppTheme.lg),
                      // Price aur timeline ki quick summary.
                      FadeIn(
                        delay: 80,
                        child: Wrap(
                          spacing: AppTheme.sm,
                          runSpacing: AppTheme.sm,
                          children: [
                            if (service.startingPrice != null)
                              _MetaChip(
                                icon: Icons.currency_rupee_rounded,
                                label: service.startingPrice!,
                              ),
                            if (service.timeline != null)
                              _MetaChip(
                                icon: Icons.schedule_rounded,
                                label: service.timeline!,
                              ),
                            const _MetaChip(
                              icon: Icons.verified_user_outlined,
                              label: 'Free first consultation',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppTheme.xl),
                      FadeIn(
                        delay: 100,
                        child: Text("What's included", style: t.cardTitle),
                      ),
                      const SizedBox(height: AppTheme.md),
                      for (var i = 0; i < service.points.length; i++)
                        FadeIn(
                          delay: 150 + i * 80,
                          offsetY: 20,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppTheme.sm),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: AppColors.gold
                                        .withValues(alpha: 0.16),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.check_rounded,
                                      size: 13, color: AppColors.goldDark),
                                ),
                                const SizedBox(width: AppTheme.sm),
                                Expanded(
                                  child: Text(service.points[i], style: t.body),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: AppTheme.xl),
                      FadeIn(
                        delay: 300,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppTheme.lg),
                          decoration: BoxDecoration(
                            gradient: AppColors.heroGradient,
                            borderRadius:
                                BorderRadius.circular(AppTheme.radius),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Want to discuss this service?',
                                style:
                                    t.cardTitle.copyWith(color: AppColors.white),
                              ),
                              const SizedBox(height: AppTheme.xs),
                              Text(
                                'The first 30-minute consultation is free. We '
                                'agree the scope and the fee in writing before '
                                'any work starts.',
                                style: t.bodySmall.copyWith(
                                    color: AppColors.textOnDarkMuted),
                              ),
                              const SizedBox(height: AppTheme.md),
                              GoldButton(
                                label: 'Book Consultation',
                                icon: Icons.event_available_rounded,
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.xxl),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Detail header ke neeche chhoti info chip - price, timeline, etc.
class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.sm,
        vertical: AppTheme.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppColors.goldDark),
          const SizedBox(width: 6),
          Text(
            label,
            style: context.text.caption.copyWith(
              color: AppColors.goldDark,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
