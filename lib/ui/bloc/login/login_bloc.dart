import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/exception_custom.dart';
import '../../../data/model/persisted_config_data.dart';
import '../../../data/model/user.dart';
import '../../../domain/services/abstractions/i_login_service.dart';
import '../../../domain/services/abstractions/i_persistence_config_service.dart';
import '../../../utils/console_printer.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ILoginService _loginService;
  final IPersistenceConfigService _persistenceConfigService;

  LoginBloc({
    required ILoginService loginService,
    required IPersistenceConfigService persistenceConfigService,
  })  : _loginService = loginService,
        _persistenceConfigService = persistenceConfigService,
        super(const LoginState()) {
    on<LoadPersistedConfigEvent>(_onLoadPersistedConfigEvent);
    on<InputUserEvent>(_onInputUserEvent);
    on<ConfirmErrorEvent>(_onConfirmErrorEvent);
  }

  _onLoadPersistedConfigEvent(LoadPersistedConfigEvent event, Emitter<LoginState> emit) async {
    final PersistedConfigData? data = await _persistenceConfigService.getData();
    if (data == null) {
      printC(green, 'No Persisted Configuration Loaded');
    } else {
      printC(green, 'Persisted Configuration Loaded: $data');
      add(InputUserEvent(user: User(name: data.username, password: data.password)));
    }
  }

  _onInputUserEvent(InputUserEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.authenticating));
    try {
      final String token = await _loginService.login(event.user);
      await Future.delayed(const Duration(seconds: 2));
      _persistenceConfigService.saveData(PersistedConfigData(
        token: token,
        username: event.user.name,
        password: event.user.password!,
      ));
      emit(state.copyWith(status: LoginStatus.authSuccess));
    } on CustomException catch (e) {
      emit(state.copyWith(
        status: LoginStatus.authFailed,
        error: () => e,
      ));
    }
  }

  _onConfirmErrorEvent(ConfirmErrorEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      status: LoginStatus.loaded,
      error: () => null,
    ));
  }
}
