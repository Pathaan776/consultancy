/// Brand aur contact details ek hi jagah.
///
/// Naam ya contact badalna ho to sirf yahan badlo - poori app update ho
/// jaayegi. Kahin bhi hardcoded brand string mat likhna.
class AppInfo {
  AppInfo._();

  /// Full legal name - footer, page title, about section.
  static const String name = 'Rahish Consultancy';

  /// Header aur footer ka wordmark. Cinzel caps mein render hota hai.
  static const String wordmark = 'RAHISH CONSULTANCY';

  /// Chhoti jagah ke liye - app launcher, browser tab.
  static const String shortName = 'Rahish Consultancy';

  static const String tagline = 'Legal & Corporate Advisory';

  /// Hero ke neeche wali line.
  static const String heroDescription =
      "India's trusted legal advisory practice - corporate advisory, "
      'intellectual property, labour law and litigation support, under one '
      'roof and in complete confidence.';

  static const String foundedLine = '15+ years of practice';

  // --- Contact (abhi placeholder - real details se replace karna hai) ---
  static const String email = 'hello@rahishconsultancy.com';
  static const String phone = '+91 00000 00000';
  static const String city = 'Varanasi';
  static const String state = 'Uttar Pradesh';
  static const String addressLine = '$city, $state';
  static const String servingLine = '$addressLine - serving clients across India';

  static const int copyrightYear = 2026;
  static String get copyright =>
      '\u00A9 $copyrightYear $name. All rights reserved.';
}
