import 'dart:async';

import 'package:baccus_kitchen/domain/repositories/abstractions/i_login_repository.dart';
import 'package:baccus_kitchen/domain/repositories/dio/i_dio_repository.dart';

class DioLoginRepository extends IDioRepository implements ILoginRepository {
  DioLoginRepository({super.url = 'kitchen/login'});

  @override
  FutureOr<String> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
