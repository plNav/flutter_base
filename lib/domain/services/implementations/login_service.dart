import 'package:baccus_kitchen/domain/repositories/abstractions/i_login_repository.dart';
import 'package:baccus_kitchen/domain/services/abstractions/i_login_service.dart';

class LoginService implements ILoginService {
  final ILoginRepository _loginRepository;

  LoginService({required ILoginRepository loginRepository}) : _loginRepository = loginRepository;

  @override
  Future<String> login(String email, String password) async {
    return _loginRepository.login(email, password);
  }
}
