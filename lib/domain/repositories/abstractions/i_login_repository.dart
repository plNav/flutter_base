import 'dart:async';

import '../../../data/model/user.dart';

abstract class ILoginRepository {
  /// Returns token to save it
  FutureOr<String> login(User user);

  /// Obtains user basic info (no params - token validation)
  FutureOr<User> getUserData();
}
