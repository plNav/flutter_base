import 'dart:async';

abstract class ILoginRepository {
  FutureOr<String> login(String email, String password);
}
