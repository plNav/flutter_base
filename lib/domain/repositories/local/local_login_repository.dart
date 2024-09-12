import 'dart:async';

import 'package:baccus_kitchen/data/model/exception_custom.dart';
import 'package:baccus_kitchen/data/model/user.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_login_repository.dart';

class LocalLoginRepository implements ILoginRepository {
  @override
  FutureOr<User> getUserData() async {
    const harcodedUserForTesting = User(id: 'testId', name: 'testName');
    return harcodedUserForTesting;
  }

  @override
  FutureOr<String> login(User user) async {
    if (user.name.isEmpty) {
      throw CustomException(
        title: 'login.error',
        message: 'Username cannot be empty',
        file: 'local_login_repository.dart',
        method: 'login',
      );
    }
    if (user.password == null || user.password!.isEmpty) {
      throw CustomException(
        title: 'login.error',
        message: 'Password cannot be null or empty',
        file: 'local_login_repository.dart',
        method: 'login',
      );    }
    return user.name;
  }
}
