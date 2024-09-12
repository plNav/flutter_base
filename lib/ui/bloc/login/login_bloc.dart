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
  }

  _onInputUserEvent(InputUserEvent event, Emitter<LoginState> emit) {
    _loginService.login(event.username, '');
  }
}
