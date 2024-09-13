import 'package:baccus_kitchen/data/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example.g.dart';

@JsonSerializable()
class Example extends Equatable{
  final String id;
  final String name;
  final String description;

  const Example(this.id, this.name, this.description);

  // Json
  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);
  Map<String, dynamic> toJson() => _$ExampleToJson(this);

  // User
  factory Example.fromModel(User user) => Example(user.id, user.name, 'empty description');
  User toModel() => User(id: id, name: name);

  @override
  List<Object?> get props => [id, name, description];
}

