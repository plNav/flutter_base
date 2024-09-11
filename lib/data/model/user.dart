import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String? password;

  const User({required this.id, required this.name, this.password});

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

  @override
  List<Object?> get props => [id, name];


}
