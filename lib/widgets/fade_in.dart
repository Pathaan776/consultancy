import 'package:flutter/material.dart';

/// Scroll par element ko fade + slide karke laata hai.
///
/// Ek baar dikh gaya to dikha hi rehta hai - baar baar scroll karne par dobara
/// animate nahi hota (warna irritating lagta hai).
///
/// ```dart
/// FadeIn(delay: 100, child: MyCard())
/// ```
///
/// Scroll detect karne ka tareeka - do galat approach pehle try ho chuki hain,
/// dono se content permanently invisible reh gaya tha:
///
/// 1. `NotificationListener<ScrollNotification>` andar lagana - ScrollNotification
///    scroll view se UPAR ki taraf bubble hoti hai, is widget tak neeche nahi
///    aati.
/// 2. `Scrollable.maybeOf(context)` - yeh sabse paas wala scrollable deta hai.
///    Grid ke andar wo GridView ka apna scrollable hota hai, jo
///    NeverScrollableScrollPhysics par hai aur kabhi move hi nahi karta.
///
/// [ScrollNotificationObserver] sahi jawab hai: wo apne poore subtree ki saari
/// scroll notifications sunta hai, chahe kitne bhi nested scrollables hon.
class FadeIn extends StatefulWidget {
  const FadeIn({
    super.key,
    required this.child,
    this.delay = 0,
    this.offsetY = 40,
    this.offsetX = 0,
    this.duration = const Duration(milliseconds: 600),
  });

  final Widget child;

  /// Milliseconds. Grid mein stagger banane ke liye use karo.
  final int delay;

  final double offsetY;
  final double offsetX;
  final Duration duration;

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> {
  ScrollNotificationObserverState? _observer;
  bool _visible = false;
  bool _scheduled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final observer = ScrollNotificationObserver.maybeOf(context);
    if (observer != _observer) {
      _detach();
      _observer = observer;
      _observer?.addListener(_onScroll);
    }

    // Jo already screen par hai usko turant dikha do.
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _detach() {
    _observer?.removeListener(_onScroll);
    _observer = null;
  }

  void _onScroll(ScrollNotification notification) => _check();

  @override
  void dispose() {
    _detach();
    super.dispose();
  }

  /// Widget screen ke andar aa gaya kya - check karta hai.
  void _check() {
    if (_scheduled || !mounted) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    // Koi observer hi nahi (static page ya test) - seedha dikha do, warna
    // content hamesha ke liye chhupa reh jaayega.
    if (_observer == null) {
      _show();
      return;
    }

    final top = box.localToGlobal(Offset.zero).dy;
    final screenH = MediaQuery.sizeOf(context).height;

    // Fold se thoda pehle trigger, taaki user ko khaali jagah na dikhe.
    if (top < screenH * 0.95 && top + box.size.height > 0) _show();
  }

  void _show() {
    if (_scheduled) return;
    _scheduled = true;
    // Reveal sirf ek baar hota hai - ab listener ki zarurat nahi.
    _detach();

    if (widget.delay == 0) {
      setState(() => _visible = true);
      return;
    }
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _visible
          ? Offset.zero
          : Offset(widget.offsetX / 100, widget.offsetY / 100),
      duration: widget.duration,
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
