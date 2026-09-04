import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';
import '../widgets/fade_in.dart';
import '../widgets/section_title.dart';
import '../widgets/section_wrapper.dart';

/// Accordion - ek time par ek hi FAQ khula rehta hai.
class FaqSection extends StatefulWidget {
  const FaqSection({super.key});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  int? _openIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      background: AppColors.offWhite,
      child: Column(
        children: [
          const SectionTitle(
            eyebrow: 'Common questions',
            title: 'Frequently Asked Questions',
          ),
          const SizedBox(height: AppTheme.xxl),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Column(
              children: [
                for (var i = 0; i < MockData.faqs.length; i++)
                  FadeIn(
                    delay: i * 70,
                    offsetY: 24,
                    child: _FaqTile(
                      faq: MockData.faqs[i],
                      open: _openIndex == i,
                      onTap: () => setState(
                        () => _openIndex = _openIndex == i ? null : i,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({
    required this.faq,
    required this.open,
    required this.onTap,
  });

  final Faq faq;
  final bool open;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.text;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.sm),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOut,
            padding: const EdgeInsets.all(AppTheme.md),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: open ? AppColors.gold : AppColors.border,
                width: open ? 1.5 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        faq.question,
                        style: t.cardTitle.copyWith(
                          fontSize: t.cardTitle.fontSize! - 1,
                        ),
                      ),
                    ),
                    // Plus se cross ki taraf ghoomta hai.
                    AnimatedRotation(
                      turns: open ? 0.125 : 0,
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOut,
                      child: Icon(
                        Icons.add_rounded,
                        color: open ? AppColors.gold : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                // Height 0 se full - smooth expand.
                AnimatedCrossFade(
                  firstChild: const SizedBox(width: double.infinity),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: AppTheme.sm),
                    child: Text(faq.answer, style: t.body),
                  ),
                  crossFadeState: open
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                  sizeCurve: Curves.easeOut,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
