import 'dart:async';

import 'package:baccus_kitchen/domain/repositories/abstractions/i_login_repository.dart';

class LocalLoginRepository implements ILoginRepository {
  @override
  FutureOr<String> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
