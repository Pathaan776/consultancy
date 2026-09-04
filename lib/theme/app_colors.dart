import 'package:flutter/material.dart';

/// Saari colors ek jagah. Widget ke andar kabhi hex mat likhna.
class AppColors {
  AppColors._();

  // Navy - main dark surface
  static const navy = Color(0xFF111827);
  static const navyMid = Color(0xFF1C2B3A);
  static const navyDeep = Color(0xFF0A192F);

  // Gold - accent
  static const gold = Color(0xFFC5A880);
  static const goldLight = Color(0xFFD4BFA0);
  static const goldDark = Color(0xFF9D8666);

  // Neutrals
  static const white = Color(0xFFFFFFFF);
  static const offWhite = Color(0xFFF9FAFB);
  static const surface = Color(0xFFF4F7F9);
  static const border = Color(0xFFE2E8F0);

  // Text
  static const text = Color(0xFF1F2937);
  static const textMuted = Color(0xFF6B7280);
  static const textOnDark = Color(0xFFF9FAFB);
  static const textOnDarkMuted = Color(0xB3F9FAFB);

  static const success = Color(0xFF27AE60);

  /// Hero ke peeche chalne wala gradient.
  static const heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [navyDeep, navy, navyMid],
  );

  static const goldGradient = LinearGradient(colors: [gold, goldLight, gold]);
}
