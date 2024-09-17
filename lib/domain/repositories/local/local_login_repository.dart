import 'dart:async';

import '../../../data/model/user.dart';
import '../abstractions/i_login_repository.dart';


class LocalLoginRepository implements ILoginRepository {
  @override
  FutureOr<User> getUserData() async {
    const hardcodedUserForTesting = User(id: 'testId', name: 'testName');
    return hardcodedUserForTesting;
  }

  @override
  FutureOr<String> login(User user) async {
    user.validate();
    return user.name;
  }
}
