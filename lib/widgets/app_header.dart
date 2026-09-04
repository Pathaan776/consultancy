import 'package:flutter/material.dart';

import '../data/app_info.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';
import 'gold_button.dart';

/// Upar chipka rehne wala header.
///
/// Hero ke upar transparent rehta hai, scroll karte hi navy solid ho jaata hai.
class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.scrolled,
    required this.onNavTap,
    required this.onMenuTap,
  });

  /// Page scroll ho chuka hai? (background solid karne ke liye)
  final bool scrolled;

  /// Kis section par jaana hai - index se decide hota hai.
  final void Function(int index) onNavTap;

  final VoidCallback onMenuTap;

  /// Desktop nav ko lagbhag 1000px chahiye. Usse chhoti screen par hamburger
  /// dikhao - warna nav items overflow ho jaate hain.
  static const double _navBreakpoint = 1000;

  @override
  Widget build(BuildContext context) {
    final compact = context.screenWidth < _navBreakpoint;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
      height: AppTheme.headerHeight,
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppTheme.md : AppTheme.xl,
      ),
      decoration: BoxDecoration(
        color: scrolled ? AppColors.navy : Colors.transparent,
        border: scrolled
            ? Border(
                bottom: BorderSide(
                  color: AppColors.gold.withValues(alpha: 0.18),
                ),
              )
            : null,
        boxShadow: scrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.22),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppTheme.maxContentWidth),
          child: Row(
            children: [
              // Flexible taaki lamba brand naam header ko tod na de.
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.balance_rounded,
                        color: AppColors.gold, size: 22),
                    const SizedBox(width: AppTheme.xs),
                    Flexible(
                      child: Text(
                        AppInfo.wordmark,
                        style: context.text.wordmark,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (!compact) ...[
                _NavItem(label: 'Services', onTap: () => onNavTap(0)),
                _NavItem(label: 'About', onTap: () => onNavTap(1)),
                _NavItem(label: 'Team', onTap: () => onNavTap(2)),
                _NavItem(label: 'FAQ', onTap: () => onNavTap(3)),
                const SizedBox(width: AppTheme.md),
                GoldButton(label: 'Contact', onPressed: () => onNavTap(4)),
              ] else
                IconButton(
                  icon: const Icon(Icons.menu_rounded, color: AppColors.white),
                  onPressed: onMenuTap,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Nav link jispar hover karne se neeche gold line grow hoti hai.
class _NavItem extends StatefulWidget {
  const _NavItem({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.sm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: context.text.navLink.copyWith(
                  color: _hover ? AppColors.gold : AppColors.white,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOut,
                height: 2,
                width: _hover ? 22 : 0,
                color: AppColors.gold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
