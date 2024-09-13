import 'dart:async';

import 'package:baccus_kitchen/data/model/exception_custom.dart';
import 'package:baccus_kitchen/data/model/persisted_config_data.dart';
import 'package:baccus_kitchen/data/model/user.dart';
import 'package:baccus_kitchen/domain/services/abstractions/i_login_service.dart';
import 'package:baccus_kitchen/domain/services/abstractions/i_persistence_config_service.dart';
import 'package:baccus_kitchen/utils/console_printer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    on<InputUserEvent>(_onInputUserEvent);
    on<ConfirmErrorEvent>(_onConfirmErrorEvent);
    on<TestIsarEvent>(_onTestIsarEvent);
  }

  _onInputUserEvent(InputUserEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.authenticating));
    try {
      await _loginService.login(event.user);
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: LoginStatus.authSuccess));
    } on CustomException catch (e) {
      emit(state.copyWith(
        status: LoginStatus.authFailed,
        error: () => e,
      ));
    }
    // Back to loaded state to prevent more listener triggers
    emit(state.copyWith(status: LoginStatus.loaded));
  }

  _onConfirmErrorEvent(ConfirmErrorEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(error: () => null));
  }

  _onTestIsarEvent(TestIsarEvent event, Emitter<LoginState> emit) async {
    final PersistedConfigData data = PersistedConfigData(
      username: 'testUsername',
      token: 'testToken',
    );
    await _persistenceConfigService.saveData(data);
    printC(warning, 'success');
    final PersistedConfigData? persisted = await _persistenceConfigService.getData();
    printC(warning, 'success');
  }
}
