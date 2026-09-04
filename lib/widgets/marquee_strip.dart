import 'package:flutter/material.dart';

/// Bina ruke chalne wali horizontal strip (seamless loop).
///
/// Track do baar draw hota hai aur exactly ek track-width translate hota hai,
/// isliye wrap point dikhta nahi. Hover par ruk jaati hai.
class MarqueeStrip extends StatefulWidget {
  const MarqueeStrip({
    super.key,
    required this.children,
    this.duration = const Duration(seconds: 35),
    this.spacing = 14,
    this.height = 44,
  });

  final List<Widget> children;

  /// Ek poora chakkar kitni der mein. Zyada = dheema.
  final Duration duration;

  final double spacing;
  final double height;

  @override
  State<MarqueeStrip> createState() => _MarqueeStripState();
}

class _MarqueeStripState extends State<MarqueeStrip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: widget.duration);

  final _trackKey = GlobalKey();
  double _trackWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  void _measure() {
    if (!mounted) return;
    final box = _trackKey.currentContext?.findRenderObject() as RenderBox?;
    final w = box?.size.width ?? 0;
    if (w > 0 && w != _trackWidth) setState(() => _trackWidth = w);
    if (!_c.isAnimating) _c.repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _track({Key? key}) => Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final child in widget.children)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
              child: child,
            ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _c.stop(),
      onExit: (_) => _c.repeat(),
      child: SizedBox(
        height: widget.height,
        child: ClipRect(
          child: ShaderMask(
            // Dono kinaron par fade, taaki items achanak se pop na karein.
            shaderCallback: (rect) => const LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black,
                Colors.black,
                Colors.transparent,
              ],
              stops: [0, 0.07, 0.93, 1],
            ).createShader(rect),
            blendMode: BlendMode.dstIn,
            // Track jaan-boojh kar screen se chaudi hai. OverflowBox usse
            // natural width par layout hone deta hai, warna Row overflow
            // assert karta hai (ClipRect sirf paint clip karta hai).
            child: OverflowBox(
              maxWidth: double.infinity,
              alignment: Alignment.centerLeft,
              child: AnimatedBuilder(
                animation: _c,
                builder: (context, _) => Transform.translate(
                  offset: Offset(-_c.value * _trackWidth, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _track(key: _trackKey),
                      _track(), // doosri copy = seamless wrap
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
