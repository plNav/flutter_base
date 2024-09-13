import 'dart:ui';

enum SupportedLocale {
  german('de'),
  english('en'),
  spanish('es');

  final String code;

  Locale toLocale() => Locale(code);

  static SupportedLocale fromLocale(Locale locale) {
    return SupportedLocale.values.firstWhere(
      (supportedLocale) => supportedLocale.code == locale.languageCode,
      orElse: () => SupportedLocale.english,
    );
  }

  const SupportedLocale(this.code);
}
