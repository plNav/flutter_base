import 'dart:async';

import 'package:baccus_kitchen/data/model/user.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_login_repository.dart';

class LocalLoginRepository implements ILoginRepository {
  @override
  FutureOr<User> getUserData() {
    const harcodedUserForTesting = User(id: 'id', name: 'name');
    return harcodedUserForTesting;
  }

  @override
  FutureOr<String> login(User user) {
    return user.name;
  }
}
