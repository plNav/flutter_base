import 'dart:async';

import 'package:baccus_kitchen/data/model/user.dart';

abstract class ILoginRepository {
  /// Returns token
  FutureOr<String> login(User user);
  FutureOr<User> getUserData();
}
