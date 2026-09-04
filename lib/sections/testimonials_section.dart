import 'dart:async';

import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';
import '../widgets/fade_in.dart';
import '../widgets/section_title.dart';
import '../widgets/section_wrapper.dart';

/// Auto-play hone wala testimonial carousel.
///
/// User swipe kare to auto-play band ho jaata hai - warna control cheen jaata
/// hai aur irritating lagta hai.
class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final _controller = PageController();
  Timer? _autoPlay;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _autoPlay = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || !_controller.hasClients) return;
      final next = (_page + 1) % MockData.testimonials.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeOutCubic,
      );
    });
  }

  /// User ne khud swipe/tap kiya - ab auto-play band. Warna control cheen
  /// jaata hai aur padhte waqt slide badal jaati hai.
  void _stopAutoPlay() {
    _autoPlay?.cancel();
    _autoPlay = null;
  }

  @override
  void dispose() {
    _autoPlay?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      background: AppColors.white,
      child: Column(
        children: [
          const SectionTitle(
            eyebrow: 'Client voices',
            title: 'Testimonials',
          ),
          const SizedBox(height: AppTheme.xxl),
          FadeIn(
            child: SizedBox(
              height: context.isMobile ? 300 : 250,
              child: Listener(
                onPointerDown: (_) => _stopAutoPlay(),
                child: PageView.builder(
                  controller: _controller,
                  itemCount: MockData.testimonials.length,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppTheme.xs),
                    child: _Card(item: MockData.testimonials[i]),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.lg),
          // Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < MockData.testimonials.length; i++)
                GestureDetector(
                  onTap: () {
                    _stopAutoPlay();
                    _controller.animateToPage(
                      i,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOut,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _page == i ? 26 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _page == i ? AppColors.gold : AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.item});

  final Testimonial item;

  @override
  Widget build(BuildContext context) {
    final t = context.text;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.xl),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppTheme.radius),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.format_quote_rounded,
                  size: 34, color: AppColors.gold),
              const SizedBox(height: AppTheme.sm),
              Flexible(
                child: Text(
                  item.quote,
                  style: t.quote,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppTheme.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < item.rating; i++)
                    const Icon(Icons.star_rounded,
                        size: 16, color: AppColors.gold),
                ],
              ),
              const SizedBox(height: AppTheme.xs),
              Text(item.author, style: t.cardTitle),
              Text(item.role, style: t.caption),
            ],
          ),
        ),
      ),
    );
  }
}
