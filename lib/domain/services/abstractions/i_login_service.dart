import 'dart:async';

import 'package:baccus_kitchen/data/model/user.dart';

abstract class ILoginService {
  FutureOr<String> login(User user);
  FutureOr<User> getUserData();
}
