import 'dart:async';

import 'package:baccus_kitchen/data/model/user.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_login_repository.dart';
import 'package:baccus_kitchen/domain/services/abstractions/i_login_service.dart';

class LoginService implements ILoginService {
  final ILoginRepository _loginRepository;

  LoginService({required ILoginRepository loginRepository}) : _loginRepository = loginRepository;

  @override
  Future<String> login(User user) async {
    return await _loginRepository.login(user);
  }

  @override
  FutureOr<User> getUserData() async {
    return await _loginRepository.getUserData();
  }
}
