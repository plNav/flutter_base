import 'dart:async';

import 'package:baccus_kitchen/data/dto/login_response_dto.dart';
import 'package:baccus_kitchen/data/dto/user_dto.dart';
import 'package:baccus_kitchen/data/enum/exception_type.dart';
import 'package:baccus_kitchen/data/model/exception_custom.dart';
import 'package:baccus_kitchen/data/model/user.dart';
import 'package:baccus_kitchen/domain/repositories/abstractions/i_login_repository.dart';
import 'package:baccus_kitchen/domain/repositories/i_dio_repository.dart';

class DioLoginRepository extends IDioRepository implements ILoginRepository {
  DioLoginRepository({super.url = '/login'});

  @override
  FutureOr<User> getUserData() async {
    final loginEndpoint = '$url/auth';
    final res = await dio.get(loginEndpoint);
    final json = await res.data;
    final UserDto user = UserDto.fromJson(json);
    return user.toUser();
  }

  @override
  FutureOr<String> login(User user) async {
    user.validate();
    final loginEndpoint = '$url/auth';
    try {
      final data = UserDto.fromUser(user).toJson();
      final res = await dio.post(loginEndpoint, data: data);
      final json = await res.data;
      final LoginResponseDto loginDto = LoginResponseDto.fromJson(json);
      if (loginDto.token.isNotEmpty) dioClient.setToken(loginDto.token);
      return loginDto.username;
    } catch (e) {
      throw CustomException(
        type: ExceptionType.loginIncorrect,
        originalException: e,
        file: 'dio_login_repository.dart',
        method: 'login',
      );
    }
  }
}
