import 'dart:async';

import '../../../data/model/user.dart';


abstract class ILoginService {
  FutureOr<String> login(User user);
  FutureOr<User> getUserData();
}
