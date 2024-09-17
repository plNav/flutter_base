import 'dart:async';

import '../../../data/model/user.dart';
import '../../repositories/abstractions/i_login_repository.dart';
import '../abstractions/i_login_service.dart';


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
