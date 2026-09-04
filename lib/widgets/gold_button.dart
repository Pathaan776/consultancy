import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/app_theme.dart';

enum GoldButtonStyle { filled, outlined }

/// App ka ek hi button. Hover par halka upar uthta hai aur glow aata hai.
class GoldButton extends StatefulWidget {
  const GoldButton({
    super.key,
    required this.label,
    this.onPressed,
    this.style = GoldButtonStyle.filled,
    this.icon,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final GoldButtonStyle style;
  final IconData? icon;
  final bool expand;

  @override
  State<GoldButton> createState() => _GoldButtonState();
}

class _GoldButtonState extends State<GoldButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final filled = widget.style == GoldButtonStyle.filled;
    final fg = filled ? AppColors.navy : AppColors.goldLight;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..translateByDouble(0, _hover ? -3 : 0, 0, 1),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.lg,
            vertical: AppTheme.sm + 2,
          ),
          decoration: BoxDecoration(
            color: filled
                ? (_hover ? AppColors.goldLight : AppColors.gold)
                : Colors.transparent,
            border: filled ? null : Border.all(color: AppColors.gold, width: 1.4),
            borderRadius: BorderRadius.circular(10),
            boxShadow: _hover && filled
                ? [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.45),
                      blurRadius: 22,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 17, color: fg),
                const SizedBox(width: AppTheme.xs),
              ],
              Text(widget.label, style: context.text.button.copyWith(color: fg)),
            ],
          ),
        ),
      ),
    );
  }
}
