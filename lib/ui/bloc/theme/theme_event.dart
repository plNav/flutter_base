part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class ToggleSchemaEvent extends ThemeEvent {}

class LoadPersistedThemeEvent extends ThemeEvent {
  final ThemeMode initialTheme;
  final Locale initialLocale;

  const LoadPersistedThemeEvent({required this.initialTheme, required this.initialLocale});

  @override
  List<Object?> get props => [initialTheme, initialLocale];
}

class ChangeLocaleEvent extends ThemeEvent {
  final SupportedLocale locale;

  const ChangeLocaleEvent({required this.locale});

  @override
  List<Object?> get props => [locale];
}
