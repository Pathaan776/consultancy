import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';

/// Poori width ka section jiske andar content beech mein aur width-capped hota
/// hai. Har section ka vertical spacing yahin se aata hai - consistent rehta hai.
class SectionWrapper extends StatelessWidget {
  const SectionWrapper({
    super.key,
    required this.child,
    this.background = AppColors.offWhite,
    this.gradient,
    this.verticalPadding,
  });

  final Widget child;
  final Color background;
  final Gradient? gradient;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    final pad = verticalPadding ?? (context.isMobile ? AppTheme.xxl : 90.0);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: gradient == null ? background : null,
        gradient: gradient,
      ),
      padding: EdgeInsets.symmetric(
        vertical: pad,
        horizontal: context.isMobile ? AppTheme.md : AppTheme.xl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppTheme.maxContentWidth),
          child: child,
        ),
      ),
    );
  }
}
