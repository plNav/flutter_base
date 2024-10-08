part of 'theme_bloc.dart';

final class ThemeState extends Equatable {
  final ThemeMode? themeMode;
  final Locale? locale;

  const ThemeState({
    this.themeMode,
    this.locale,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [themeMode, locale];
}
