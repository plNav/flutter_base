import 'package:baccus_kitchen/data/model/user.dart';
import 'package:baccus_kitchen/domain/services/abstractions/i_login_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ILoginService _loginService;

  HomeBloc({required ILoginService loginService})
      : _loginService = loginService,
        super(const HomeState()) {
    on<GetUserInfoEvent>(_onGetUserInfoEvent);
  }

  _onGetUserInfoEvent(GetUserInfoEvent event, Emitter<HomeState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    final User user = await _loginService.getUserData();
    emit(state.copyWith(
      status: HomeStatus.loaded,
      user: () => user,
    ));
  }
}
