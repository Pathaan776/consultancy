import 'package:flutter/material.dart';

import '../data/app_info.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';
import '../widgets/fade_in.dart';
import '../widgets/gold_button.dart';
import '../widgets/section_wrapper.dart';

/// Do column layout - desktop par side by side, mobile par stack.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    final text = FadeIn(
      offsetX: isMobile ? 0 : -30,
      offsetY: isMobile ? 30 : 0,
      child: _AboutText(),
    );

    final visual = FadeIn(
      delay: 150,
      offsetX: isMobile ? 0 : 30,
      offsetY: isMobile ? 30 : 0,
      child: const _AboutVisual(),
    );

    return SectionWrapper(
      background: AppColors.offWhite,
      child: isMobile
          ? Column(
              children: [text, const SizedBox(height: AppTheme.xl), visual],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: text),
                const SizedBox(width: AppTheme.xxl),
                Expanded(flex: 5, child: visual),
              ],
            ),
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = context.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('WHO WE ARE', style: t.eyebrow),
        const SizedBox(height: AppTheme.sm),
        Text('About ${AppInfo.name}', style: t.sectionTitle),
        const SizedBox(height: AppTheme.sm),
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            gradient: AppColors.goldGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: AppTheme.lg),
        Text(
          '${AppInfo.name} is a legal consultancy based in ${AppInfo.city}, '
          'working with businesses and individuals across India. Our approach '
          'is simple: '
          'explain the position in plain language, lay out the real options, '
          'and let you make the decision.',
          style: t.bodyLarge,
        ),
        const SizedBox(height: AppTheme.md),
        Text(
          'From company registration to court representation, every matter is '
          'assigned to a named advocate who stays your point of contact '
          'throughout. Fees are agreed in writing before work begins - no '
          'surprise invoices at the end.',
          style: t.body.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: AppTheme.lg),
        Wrap(
          spacing: AppTheme.lg,
          runSpacing: AppTheme.sm,
          children: const [
            _Point(text: 'Fixed fees agreed up front'),
            _Point(text: 'A named advocate on every matter'),
            _Point(text: 'Pan-India associate network'),
            _Point(text: 'Response within one working day'),
          ],
        ),
        const SizedBox(height: AppTheme.xl),
        GoldButton(
          label: 'Talk to Our Team',
          icon: Icons.arrow_forward_rounded,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _Point extends StatelessWidget {
  const _Point({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle_rounded,
            size: 17, color: AppColors.success),
        const SizedBox(width: AppTheme.xs),
        // Flexible - chhote phones par lambi line Wrap ki width se bahar
        // nikal jaati thi.
        Flexible(child: Text(text, style: context.text.bodySmall)),
      ],
    );
  }
}

/// Right side ka decorative panel - dheere se saans leta hua gold badge.
class _AboutVisual extends StatefulWidget {
  const _AboutVisual();

  @override
  State<_AboutVisual> createState() => _AboutVisualState();
}

class _AboutVisualState extends State<_AboutVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.text;

    return AspectRatio(
      aspectRatio: 1.05,
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.heroGradient,
          borderRadius: BorderRadius.circular(AppTheme.radius + 6),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withValues(alpha: 0.25),
              blurRadius: 40,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Halka sa float karta hua icon
            AnimatedBuilder(
              animation: _c,
              builder: (context, child) => Transform.translate(
                offset: Offset(0, -12 * Curves.easeInOut.transform(_c.value)),
                child: child,
              ),
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: 0.4),
                  ),
                ),
                child: const Icon(Icons.balance_rounded,
                    size: 48, color: AppColors.goldLight),
              ),
            ),
            Positioned(
              bottom: AppTheme.lg,
              left: AppTheme.lg,
              right: AppTheme.lg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppInfo.foundedLine,
                      style: t.cardTitle.copyWith(color: AppColors.white)),
                  const SizedBox(height: 4),
                  Text(
                    AppInfo.servingLine,
                    style: t.bodySmall
                        .copyWith(color: AppColors.textOnDarkMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
