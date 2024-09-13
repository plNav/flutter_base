part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class LoadPersistedThemeEvent extends ThemeEvent {}

class ToggleSchemaEvent extends ThemeEvent {}

class ChangeLocaleEvent extends ThemeEvent {
  final SupportedLocale locale;

  const ChangeLocaleEvent({required this.locale});

  @override
  List<Object?> get props => [locale];
}
