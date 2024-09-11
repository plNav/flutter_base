# DATA

```
project_name/ 
├── lib/
│   ├── data/
│   │   ├── model/
│   │   ├── enum/
│   │   └── dto/
```

## MODEL

- The class is an immutable and constant model.

- It is defined using `Equatable` to enable value-based equality comparison.

- Can have logic with custom private or public methods

- Should not be `Serializable` - Use the `dto` classes

- The `copyWith` method allows cloning of the `User` object with selective updates, especially
  handling the `password` differently by using a functional approach (`String? Function()`).

- The `props` list does **not include** the `password`, meaning users with the same `id` and `name`
  are considered equal regardless of their `password`.

> This class is marked as `const`, meaning all instances of `User` must be constant, which
> enhances performance and immutability in Dart.
> Any changes to the object can only be made via the `copyWith` method.


### Equatable
Docs: [Equatable](https://pub.dev/packages/json_serializable).


### Code Example

```dart
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String? password;

  const User({required this.id, required this.name, this.password});

  // + Class methods

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
```

### Usage Example

```dart
void main() {
  // Initial User instance with id, name, and password
  const user = User(id: '123', name: 'Alice', password: 'secret123');

  // Example 1: Changing the name while keeping the password unchanged
  final user1 = user.copyWith(name: 'Bob');
  print('Example 1: user1 -> $user1');
  // Result: user1 -> User(123, Bob, secret123)

  // Example 2: Setting the password to null using password: () => null
  final user2 = user.copyWith(password: () => null);
  print('Example 2: user2 -> $user2');
  // Result: user2 -> User(123, Alice, null)

  // Example 3: Keeping the original password by passing password: null
  final user3 = user.copyWith(password: null);
  print('Example 3: user3 -> $user3');
  // Result: user3 -> User(123, Alice, secret123)

  // Example 4: Updating the password with a new value using password: () => "new_password"
  final user4 = user.copyWith(password: () => 'new_password');
  print('Example 4: user4 -> $user4');
  // Result: user4 -> User(123, Alice, new_password)
}
```

# DTO

- Constant classes with the only functionality of exchanging data with APIs or other services.

- Cannot have logic. Don't define the `copyWith()` method

- Requests can be constructed from variables or one or more models (Define Constructor)

- Responses can be casted to models or variables(Define methods)

- Should be `Serializable` and `Equatable` with all the props

- Nullable variables are not recommended, the attribute will not be present when converted to JSON

### Json Build Runner (Serialization Generator)

Docs: [JsonSerializable](https://pub.dev/packages/json_serializable).

> Generates files to parse classes to json and vice-versa in network exchanges.

> Requires to create a `build.yaml` configuration file in project root

### Serialized Class Example `example.dart`

```dart
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
  factory Example.fromUser(User user) => Example(user.id, user.name, 'empty description');
  User toUser() => User(id: id, name: name);

  @override
  List<Object?> get props => [id, name, description];
}
```

Command (Terminal) to Generate:
```bash
dart run build_runner build
```
> ⚠ Use this command only in the project root!

It will generate `example.g.dart`:
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Example _$ExampleFromJson(Map<String, dynamic> json) => Example(
      json['id'] as String,
      json['name'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$ExampleToJson(Example instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
```

## ENUM

- Constant lists for handling states, options...
- Can have additional constant properties for each value

### Code Examples

```dart
enum DocumentStatus {
  draft,
  review,
  approved,
  rejected,
  archived;
}
```

```dart
enum DocumentStatus {
  draft(0, "Draft", Colors.orange),
  review(1, "In Review", Colors.yellow),
  approved(2, "Approved", Colors.green),
  rejected(3, "Rejected", Colors.red),
  archived(4, "Archived", Colors.blue);

  final int level;
  final String label;
  final Color displayColor;

  // A custom property that returns a fallback color when needed
  Color get defaultColor => Colors.grey;

  // Enum constructor with custom properties
  const DocumentStatus(this.level, this.label, this.displayColor);
}
```

#### Serialization and Deserialization:

>When you use an enum in a DTO (Data Transfer Object), Dart will automatically handle the serialization and deserialization of enum values. 
>This means you don’t need to explicitly mark the enum with `@Serializable`.
>The value will be serialized into a JSON string, and when received, it will be deserialized back into its corresponding enum value.


