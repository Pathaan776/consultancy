import 'package:flutter/material.dart';

/// 0 se target tak ginne wala counter, jo screen par aane par shuru hota hai.
///
/// [FadeIn] ki tarah yeh bhi [ScrollNotificationObserver] use karta hai -
/// wajah wahin comment mein likhi hai.
class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    super.key,
    required this.value,
    required this.style,
    this.suffix = '',
    this.duration = const Duration(milliseconds: 1800),
  });

  final int value;
  final TextStyle style;
  final String suffix;
  final Duration duration;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: widget.duration);

  late final Animation<double> _anim = CurvedAnimation(
    parent: _c,
    // Tez shuru, dheere khatam - counting natural lagti hai.
    curve: Curves.easeOutExpo,
  );

  ScrollNotificationObserverState? _observer;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final observer = ScrollNotificationObserver.maybeOf(context);
    if (observer != _observer) {
      _detach();
      _observer = observer;
      _observer?.addListener(_onScroll);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeStart());
  }

  void _detach() {
    _observer?.removeListener(_onScroll);
    _observer = null;
  }

  void _onScroll(ScrollNotification notification) => _maybeStart();

  void _maybeStart() {
    if (_started || !mounted) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final onScreen = _observer == null ||
        box.localToGlobal(Offset.zero).dy <
            MediaQuery.sizeOf(context).height * 0.92;

    if (onScreen) {
      _started = true;
      _detach();
      _c.forward();
    }
  }

  @override
  void dispose() {
    _detach();
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) {
        final current = (widget.value * _anim.value).round();
        return Text('$current${widget.suffix}', style: widget.style);
      },
    );
  }
}
