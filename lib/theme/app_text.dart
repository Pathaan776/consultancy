import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Reusable typography.
///
/// Har text style ka ek naam hai. Widget mein kabhi `fontSize: 24` mat likhna -
/// yahan se style uthao:
///
/// ```dart
/// Text('Our Services', style: context.text.sectionTitle)
/// ```
///
/// Screen chhoti ho to poori scale ek saath chhoti hoti hai, isliye proportions
/// bigadte nahi.
class AppText {
  const AppText._(this._scale);

  final double _scale;

  /// Screen width ke hisaab se scale chunta hai.
  factory AppText.of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return const AppText._(0.72);
    if (width < 1024) return const AppText._(0.86);
    return const AppText._(1);
  }

  static TextStyle _display(TextStyle s) => GoogleFonts.cinzel(textStyle: s);
  static TextStyle _serif(TextStyle s) => GoogleFonts.cormorantGaramond(textStyle: s);
  static TextStyle _sans(TextStyle s) => GoogleFonts.plusJakartaSans(textStyle: s);

  double _s(double size) => size * _scale;

  // --- Hero ---
  TextStyle get heroTitle => _display(TextStyle(
        fontSize: _s(64),
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: _s(6),
        color: AppColors.white,
      ));

  TextStyle get heroSubtitle => _sans(TextStyle(
        fontSize: _s(17),
        height: 1.7,
        color: AppColors.textOnDarkMuted,
      ));

  // --- Sections ---
  TextStyle get sectionTitle => _display(TextStyle(
        fontSize: _s(34),
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: _s(1.6),
        color: AppColors.navy,
      ));

  TextStyle get sectionSubtitle => _sans(TextStyle(
        fontSize: _s(16),
        height: 1.65,
        color: AppColors.textMuted,
      ));

  TextStyle get eyebrow => _sans(TextStyle(
        fontSize: _s(12),
        fontWeight: FontWeight.w700,
        letterSpacing: _s(2.4),
        color: AppColors.gold,
      ));

  // --- Cards ---
  TextStyle get cardTitle => _sans(TextStyle(
        fontSize: _s(18),
        fontWeight: FontWeight.w700,
        height: 1.35,
        color: AppColors.navy,
      ));

  TextStyle get cardBody => _sans(TextStyle(
        fontSize: _s(14.5),
        height: 1.6,
        color: AppColors.textMuted,
      ));

  // --- Body ---
  TextStyle get bodyLarge => _sans(TextStyle(
        fontSize: _s(17),
        height: 1.75,
        color: AppColors.text,
      ));

  TextStyle get body => _sans(TextStyle(
        fontSize: _s(15.5),
        height: 1.7,
        color: AppColors.text,
      ));

  TextStyle get bodySmall => _sans(TextStyle(
        fontSize: _s(13.5),
        height: 1.6,
        color: AppColors.textMuted,
      ));

  /// Testimonials ke liye italic serif.
  TextStyle get quote => _serif(TextStyle(
        fontSize: _s(21),
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
        height: 1.55,
        color: AppColors.text,
      ));

  // --- Interactive ---
  TextStyle get navLink => _sans(TextStyle(
        fontSize: _s(14.5),
        fontWeight: FontWeight.w600,
        letterSpacing: _s(0.3),
        color: AppColors.navy,
      ));

  TextStyle get button => _sans(TextStyle(
        fontSize: _s(14.5),
        fontWeight: FontWeight.w700,
        letterSpacing: _s(0.6),
      ));

  TextStyle get caption => _sans(TextStyle(
        fontSize: _s(12),
        fontWeight: FontWeight.w500,
        letterSpacing: _s(0.2),
        color: AppColors.textMuted,
      ));

  /// Counter ka bada number.
  TextStyle get stat => _display(TextStyle(
        fontSize: _s(46),
        fontWeight: FontWeight.w700,
        height: 1,
        color: AppColors.gold,
      ));

  /// Brand wordmark - header aur footer dono mein.
  TextStyle get wordmark => _display(TextStyle(
        fontSize: _s(18),
        fontWeight: FontWeight.w700,
        letterSpacing: _s(3),
        color: AppColors.white,
      ));
}

/// Shortcuts: `context.text.sectionTitle`, `context.isMobile`
extension AppTextX on BuildContext {
  AppText get text => AppText.of(this);

  bool get isMobile => MediaQuery.sizeOf(this).width < 800;
  bool get isTablet {
    final w = MediaQuery.sizeOf(this).width;
    return w >= 800 && w < 1200;
  }

  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
}
