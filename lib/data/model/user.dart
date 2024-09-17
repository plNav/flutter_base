import 'package:equatable/equatable.dart';
import '../enum/exception_type.dart';
import 'exception_custom.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String? password;

  const User({this.id = '', required this.name, this.password});

  User copyWith({
    String? id,
    String? name,
    String? Function()? password,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password == null ? this.password : password(),
    );
  }

  /// Throws custom exception if empty name or password
  validate() {
    if (name.isEmpty) {
      throw CustomException(type: ExceptionType.loginUserEmpty);
    }
    if (password == null || password!.isEmpty) {
      throw CustomException(type: ExceptionType.loginPassEmpty);
    }
  }

  @override
  List<Object?> get props => [id, name];
}
