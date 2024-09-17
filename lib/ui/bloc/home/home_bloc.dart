import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/user.dart';
import '../../../domain/services/abstractions/i_login_service.dart';
import '../../../domain/services/abstractions/i_persistence_config_service.dart';
import '../../../domain/services/abstractions/i_persistence_theme_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ILoginService _loginService;
  final IPersistenceThemeService _persistenceThemeService;
  final IPersistenceConfigService _persistenceConfigService;

  HomeBloc({
    required ILoginService loginService,
    required IPersistenceThemeService persistenceThemeService,
    required IPersistenceConfigService persistenceConfigService,
  })  : _loginService = loginService,
        _persistenceThemeService = persistenceThemeService,
        _persistenceConfigService = persistenceConfigService,
        super(const HomeState()) {
    on<GetUserInfoEvent>(_onGetUserInfoEvent);
    on<ClearStorageEvent>(_onClearStorageEvent);
  }

  _onGetUserInfoEvent(GetUserInfoEvent event, Emitter<HomeState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    final User user = await _loginService.getUserData();
    emit(state.copyWith(
      status: HomeStatus.loaded,
      user: () => user,
    ));
  }

  _onClearStorageEvent(ClearStorageEvent event, Emitter<HomeState> emit) async {
    await _persistenceConfigService.deleteAll();
    await _persistenceThemeService.deleteAll();
  }
}
