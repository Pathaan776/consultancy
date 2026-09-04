import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/app_info.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';
import '../widgets/gold_button.dart';
import '../widgets/marquee_strip.dart';

/// Full-screen hero.
///
/// Background mein koi video nahi - teen dheere-dheere ghoomte gold orbs aur
/// gradient hai. Isse teeno platforms par same dikhta hai, koi plugin nahi
/// chahiye, aur mobile par battery bhi nahi khaata.
class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.onExploreTap});

  final VoidCallback onExploreTap;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  /// Background orbs - slow, infinite.
  late final AnimationController _bg = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 18),
  )..repeat();

  /// Content ka entry animation - ek hi controller, alag alag intervals.
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  );

  /// Neeche wala scroll arrow - upar neeche bounce.
  late final AnimationController _bounce = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    _intro.forward();
  }

  @override
  void dispose() {
    _bg.dispose();
    _intro.dispose();
    _bounce.dispose();
    super.dispose();
  }

  /// Staggered entry: har element thoda baad mein aata hai.
  Widget _staggered({
    required double start,
    required double end,
    required Widget child,
  }) {
    final anim = CurvedAnimation(
      parent: _intro,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
    return AnimatedBuilder(
      animation: anim,
      builder: (context, _) => Opacity(
        opacity: anim.value,
        child: Transform.translate(
          offset: Offset(0, 28 * (1 - anim.value)),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.text;
    final isMobile = context.isMobile;

    return SizedBox(
      height: context.screenHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Gradient base
          const DecoratedBox(
            decoration: BoxDecoration(gradient: AppColors.heroGradient),
          ),

          // 2. Ghoomte hue gold orbs
          AnimatedBuilder(
            animation: _bg,
            builder: (context, _) => CustomPaint(
              painter: _OrbPainter(_bg.value),
            ),
          ),

          // 3. Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppTheme.lg : AppTheme.xxl,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _staggered(
                    start: 0.0,
                    end: 0.35,
                    child: Text('LEGAL EXCELLENCE, SINCE 2010',
                        style: t.eyebrow, textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: AppTheme.md),
                  _staggered(
                    start: 0.1,
                    end: 0.5,
                    child: Text(AppInfo.wordmark,
                        style: t.heroTitle, textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: AppTheme.lg),
                  _staggered(start: 0.25, end: 0.6, child: const _Divider()),
                  const SizedBox(height: AppTheme.lg),
                  _staggered(
                    start: 0.35,
                    end: 0.72,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 660),
                      child: Text(
                        AppInfo.heroDescription,
                        style: t.heroSubtitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.xl),
                  _staggered(
                    start: 0.5,
                    end: 0.85,
                    child: Wrap(
                      spacing: AppTheme.md,
                      runSpacing: AppTheme.sm,
                      alignment: WrapAlignment.center,
                      children: [
                        GoldButton(
                          label: 'Book a Consultation',
                          icon: Icons.event_available_rounded,
                          onPressed: () {},
                        ),
                        GoldButton(
                          label: 'Our Services',
                          style: GoldButtonStyle.outlined,
                          onPressed: widget.onExploreTap,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Neeche chalti service strip
          Positioned(
            left: 0,
            right: 0,
            bottom: isMobile ? 74 : 92,
            child: _staggered(
              start: 0.65,
              end: 1.0,
              child: MarqueeStrip(
                children: [
                  for (final item in MockData.marqueeItems) _Chip(label: item),
                ],
              ),
            ),
          ),

          // 5. Scroll cue
          Positioned(
            left: 0,
            right: 0,
            bottom: AppTheme.lg,
            child: AnimatedBuilder(
              animation: _bounce,
              builder: (context, child) => Transform.translate(
                offset: Offset(0, -10 * Curves.easeInOut.transform(_bounce.value)),
                child: child,
              ),
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.goldLight,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Title ke neeche gold line + heera.
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 60, height: 1, color: AppColors.gold),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.sm),
          child: Icon(Icons.diamond_outlined, size: 13, color: AppColors.gold),
        ),
        Container(width: 60, height: 1, color: AppColors.gold),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.md,
        vertical: AppTheme.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.08),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.28)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: context.text.caption.copyWith(
          color: AppColors.textOnDarkMuted,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

/// Background ke teen dheere ghoomte gold orbs.
///
/// CustomPainter isliye ki yeh sirf paint karta hai - koi widget rebuild nahi
/// hota, to 60fps par bhi sasta rehta hai.
class _OrbPainter extends CustomPainter {
  const _OrbPainter(this.progress);

  /// 0 se 1 tak, loop mein.
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final angle = progress * 2 * math.pi;

    final orbs = [
      (
        center: Offset(
          size.width * 0.22 + math.cos(angle) * 60,
          size.height * 0.28 + math.sin(angle) * 45,
        ),
        radius: size.width * 0.30,
        opacity: 0.17,
      ),
      (
        center: Offset(
          size.width * 0.82 + math.cos(angle + 2.1) * 70,
          size.height * 0.62 + math.sin(angle + 2.1) * 55,
        ),
        radius: size.width * 0.26,
        opacity: 0.13,
      ),
      (
        center: Offset(
          size.width * 0.55 + math.cos(angle + 4.2) * 90,
          size.height * 0.88 + math.sin(angle + 4.2) * 40,
        ),
        radius: size.width * 0.22,
        opacity: 0.10,
      ),
    ];

    for (final orb in orbs) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.gold.withValues(alpha: orb.opacity),
            AppColors.gold.withValues(alpha: 0),
          ],
        ).createShader(
          Rect.fromCircle(center: orb.center, radius: orb.radius),
        );
      canvas.drawCircle(orb.center, orb.radius, paint);
    }
  }

  @override
  bool shouldRepaint(_OrbPainter old) => old.progress != progress;
}
