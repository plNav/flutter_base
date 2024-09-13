import 'dart:async';

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
    user.validate();
    return user.name;
  }
}
