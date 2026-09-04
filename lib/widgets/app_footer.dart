import 'package:flutter/material.dart';

import '../data/app_info.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.text;
    final isMobile = context.isMobile;

    return Container(
      width: double.infinity,
      color: AppColors.navyDeep,
      padding: EdgeInsets.symmetric(
        vertical: AppTheme.xxl,
        horizontal: isMobile ? AppTheme.md : AppTheme.xl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppTheme.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: AppTheme.xxl,
                runSpacing: AppTheme.xl,
                children: [
                  SizedBox(
                    width: 320,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.balance_rounded,
                                color: AppColors.gold, size: 20),
                            const SizedBox(width: AppTheme.xs),
                            // Flexible taaki bade type scale par bhi
                            // wordmark overflow na kare.
                            Flexible(
                              child: Text(
                                AppInfo.wordmark,
                                style: t.wordmark,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppTheme.sm),
                        Text(
                          'A legal consultancy based in ${AppInfo.city}, '
                          'advising businesses and families across India.',
                          style: t.bodySmall
                              .copyWith(color: AppColors.textOnDarkMuted),
                        ),
                        const SizedBox(height: AppTheme.md),
                        Row(
                          children: [
                            for (final icon in [
                              Icons.mail_outline_rounded,
                              Icons.phone_outlined,
                              Icons.location_on_outlined,
                            ])
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: AppTheme.sm),
                                child: _SocialDot(icon: icon),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _Column(
                    title: 'Company',
                    items: const ['About Us', 'Our Team', 'Achievements', 'Careers'],
                  ),
                  _Column(
                    title: 'Practice Areas',
                    items: const [
                      'Corporate Advisory',
                      'Trademark & IP',
                      'Labour Law',
                      'Property & Real Estate',
                    ],
                  ),
                  _Column(
                    title: 'Get in Touch',
                    items: const [
                      AppInfo.email,
                      AppInfo.phone,
                      AppInfo.addressLine,
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.xl),
              const Divider(color: Colors.white12),
              const SizedBox(height: AppTheme.md),
              Text(
                AppInfo.copyright,
                style: t.caption.copyWith(color: AppColors.textOnDarkMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Column extends StatelessWidget {
  const _Column({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final t = context.text;
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: t.eyebrow),
          const SizedBox(height: AppTheme.sm),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.xs),
              child: _FooterLink(label: item),
            ),
        ],
      ),
    );
  }
}

/// Hover par thoda right shift hota hai aur gold ho jaata hai.
class _FooterLink extends StatefulWidget {
  const _FooterLink({required this.label});

  final String label;

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedSlide(
        offset: _hover ? const Offset(0.05, 0) : Offset.zero,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: Text(
          widget.label,
          style: context.text.bodySmall.copyWith(
            color: _hover ? AppColors.gold : AppColors.textOnDarkMuted,
          ),
        ),
      ),
    );
  }
}

class _SocialDot extends StatefulWidget {
  const _SocialDot({required this.icon});

  final IconData icon;

  @override
  State<_SocialDot> createState() => _SocialDotState();
}

class _SocialDotState extends State<_SocialDot> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: _hover
              ? AppColors.gold
              : AppColors.white.withValues(alpha: 0.07),
          shape: BoxShape.circle,
        ),
        child: Icon(
          widget.icon,
          size: 17,
          color: _hover ? AppColors.navy : AppColors.goldLight,
        ),
      ),
    );
  }
}
