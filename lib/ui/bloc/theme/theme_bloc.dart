import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/enum/supported_locale.dart';
import '../../../data/model/persisted_theme_data.dart';
import '../../../domain/services/abstractions/i_persistence_theme_service.dart';
import '../../../utils/console_printer.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final IPersistenceThemeService _persistenceThemeService;

  ThemeBloc({required IPersistenceThemeService persistenceThemeService})
      : _persistenceThemeService = persistenceThemeService,
        super(const ThemeState()) {
    on<LoadPersistedThemeEvent>(_onLoadPersistedThemeEvent);
    on<ToggleSchemaEvent>(_onToggleSchemaEvent);
    on<ChangeLocaleEvent>(_onChangeLocaleEvent);
  }

  _onLoadPersistedThemeEvent(LoadPersistedThemeEvent event, Emitter<ThemeState> emit) async {
    final data = await _persistenceThemeService.getData();
    if (data == null) {
      printC(green, 'No Persisted Theme Loaded: ${event.initialTheme} - ${event.initialLocale}');
      emit(state.copyWith(
        themeMode: event.initialTheme,
        locale: SupportedLocale.fromLocale(event.initialLocale).toLocale(),
      ));
    } else {
      printC(green, 'Theme Configuration Loaded: ${data.themeMode} - ${data.locale}');
      emit(state.copyWith(
        themeMode: data.themeMode == ThemeMode.dark.toString() ? ThemeMode.dark : ThemeMode.light,
        locale: Locale(data.locale),
      ));
    }
  }

  _onToggleSchemaEvent(ToggleSchemaEvent event, Emitter<ThemeState> emit) async {
    final newThemeMode = state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(themeMode: newThemeMode));
    await _persistenceThemeService.saveData(PersistedThemeData(
      themeMode: newThemeMode.toString(),
      locale: state.locale!.languageCode,
    ));
  }

  _onChangeLocaleEvent(ChangeLocaleEvent event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(locale: Locale(event.locale.code)));
    await _persistenceThemeService.saveData(PersistedThemeData(
      themeMode: state.themeMode.toString(),
      locale: state.locale!.languageCode,
    ));
  }
}
