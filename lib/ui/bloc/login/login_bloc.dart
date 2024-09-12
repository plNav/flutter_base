import 'dart:async';

import 'package:baccus_kitchen/data/model/exception_custom.dart';
import 'package:baccus_kitchen/data/model/user.dart';
import 'package:baccus_kitchen/domain/services/abstractions/i_login_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ILoginService _loginService;

  LoginBloc({required ILoginService loginService})
      : _loginService = loginService,
        super(const LoginState()) {
    on<InputUserEvent>(_onInputUserEvent);
    on<ConfirmErrorEvent>(_onConfirmErrorEvent);
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
    // Back to the loaded state to prevent listener triggers
    emit(state.copyWith(status: LoginStatus.loaded));
  }

  _onConfirmErrorEvent(ConfirmErrorEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(error: () => null));
  }
}
