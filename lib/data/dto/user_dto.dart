import 'package:baccus_kitchen/data/model/user.dart'; // Assuming you have a User model
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto extends Equatable {
  final String id;
  final String name;
  final String password;

  const UserDto({
    required this.id,
    required this.name,
    required this.password,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  factory UserDto.fromModel(User user) => UserDto(
        id: user.id,
        name: user.name,
        password: user.password ?? '',
      );

  User toModel() => User(
        id: id,
        name: name,
        password: password,
      );

  @override
  List<Object?> get props => [id, name, password];
}
