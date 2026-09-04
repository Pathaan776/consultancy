import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Card jo hover par upar uthta hai aur shadow gehri hoti hai.
///
/// Web/desktop par mouse hover chalta hai; mobile par tap par wahi effect
/// dikhta hai. Curve website wali hi hai - halka sa overshoot.
class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.child,
    this.onTap,
    this.lift = 10,
    this.scale = 1.0,
    this.borderRadius = 16,
  });

  final Widget child;
  final VoidCallback? onTap;

  /// Hover par kitna upar uthega (pixels).
  final double lift;

  final double scale;
  final double borderRadius;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hover = false;
  bool _pressed = false;

  bool get _active => _hover || _pressed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          // Website wala signature easing - thoda overshoot karta hai.
          curve: const Cubic(0.175, 0.885, 0.32, 1.275),
          transform: Matrix4.identity()
            ..translateByDouble(0, _active ? -widget.lift : 0, 0, 1)
            ..scaleByDouble(
              _active ? widget.scale : 1,
              _active ? widget.scale : 1,
              1,
              1,
            ),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: _active
                ? [
                    BoxShadow(
                      color: AppColors.navy.withValues(alpha: 0.16),
                      blurRadius: 34,
                      offset: const Offset(0, 16),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.navy.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
