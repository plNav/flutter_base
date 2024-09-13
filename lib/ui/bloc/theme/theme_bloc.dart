import 'package:baccus_kitchen/data/enum/supported_locale.dart';
import 'package:baccus_kitchen/domain/services/abstractions/i_persistence_theme_service.dart';
import 'package:baccus_kitchen/utils/console_printer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final IPersistenceThemeService _persistenceThemeService;

  ThemeBloc({required IPersistenceThemeService persistenceThemeService})
      : _persistenceThemeService = persistenceThemeService,
        super(const ThemeState()) {
    on<ToggleSchemaEvent>(_onToggleSchemaEvent);
    on<ChangeLocaleEvent>(_onChangeLocaleEvent);
    on<LoadPersistedThemeEvent>(_onLoadPersistedThemeEvent);
  }

  _onToggleSchemaEvent(ToggleSchemaEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      themeMode: state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    ));
    // TODO SAVE
  }

  _onChangeLocaleEvent(ChangeLocaleEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      locale: Locale(event.locale.code),
    ));
    // TODO SAVE
  }

  _onLoadPersistedThemeEvent(LoadPersistedThemeEvent event, Emitter<ThemeState> emit) async {
    final data = await _persistenceThemeService.getData();
    printC(warning, data.toString());
  }
}
