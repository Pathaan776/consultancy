import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text.dart';

/// App ka Material theme + spacing scale.
class AppTheme {
  AppTheme._();

  // Spacing - 4 ke multiples. Padding aur gap yahin se lo.
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 72;

  static const double radius = 16;
  static const double headerHeight = 72;
  static const double maxContentWidth = 1200;

  static ThemeData build(BuildContext context) {
    final t = AppText.of(context);

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.offWhite,
      colorScheme: const ColorScheme.light(
        primary: AppColors.navy,
        onPrimary: AppColors.white,
        secondary: AppColors.gold,
        onSecondary: AppColors.navy,
        surface: AppColors.white,
        onSurface: AppColors.text,
      ),
      textTheme: TextTheme(
        displayLarge: t.heroTitle,
        headlineLarge: t.sectionTitle,
        titleLarge: t.cardTitle,
        bodyLarge: t.bodyLarge,
        bodyMedium: t.body,
        bodySmall: t.bodySmall,
        labelLarge: t.button,
      ),
      // Web par Material ripple thoda odd lagta hai.
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1),
    );
  }
}
