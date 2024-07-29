# BACCUS KITCHEN

```
    baccus_kitchen/ 
    ├── lib/                    # Main directory where dart code is located. 
    │   ├── data/               # Object classes, cannot depend on other directories.
    │   │   ├── model/          # Classes that are being used on the UI.
    │   │   ├── enum/           # Data classes for types, lists and constants.
    │   │   └── dto/            # Clases used only in API exchange.
    │   ├── domain/             # Bussiness logic and core functionallity.
    │   │   ├── bloc/           # State management.
    │   │   ├── client/         # Classes for API clients and network interactions.
    │   │   ├── repository/     # Data repositories to manage data sources.
    │   │   └── service/        # Service classes for handling business operations.
    │   ├── ui/                 # User Interface components.
    │   │   ├── navigation/     # Routing logic, screen constant definitions.
    │   │   ├── screen/         # UI main components, not reusable.
    │   │   ├── theme/          # Styling and Translation configurations.
    │   │   └── widget/         # Reusable components.
    │   └── util/               # Helper classes, functions and extensions.
    ├── assets/                 # Statics assets such as images, fonts...
    ├── android/                # Autogen. Permissions in `app > src > main > AndroidManifest.xml`.
    ├── windows/                # Autogen. Platform specific code.
    ├── build/                  # Output, compilated code.
    ├── test/                   # Unit Testing.
    ├── integration_test/       # UI Testing.
    ├── analysis_options.yaml   # Linter.
    ├── build.yaml              # JsonSerializable Configuration.
    └── pubspec.yaml            # Project configuration and dependencies.
```

> Bitbucket repo
```bash
git clone https://sime_cloud@bitbucket.org/sime_cloud/baccus_kitchen.git
```

### Basic libraries   
```bash  
flutter pub add flutter_bloc equatable json_serializable json_annotation build_runner
```  

### Testing
Launch Unit Tests
```bash  
flutter test
```  
Launch Integration Tests
```bash  
flutter test integration_test
```  

### Launcher Icons

Docs: [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons).

> Add dev_dependency and configuration in pubspec.yaml

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  flutter_launcher_icons: ^0.13.1

flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/sime_square.png"
  min_sdk_android: 21
  windows:
    generate: true
    image_path: "assets/sime_square.png"
    icon_size: 48
```
Then build with command:
```bash
flutter pub run flutter_launcher_icons
```

### Json Build Runner (Serialization Generator)

Docs: [JsonSerializable](https://pub.dev/packages/json_serializable).

> Generates files to parse classes to json and vice-versa in network exchanges.

Command (Terminal) to Generate:
```bash
dart run build_runner build --delete-conflicting-outputs
```
Serialized Class Example

```dart
import 'package:json_annotation/json_annotation.dart';

part 'example.g.dart';

@JsonSerializable()
class Example {
  final String id;
  final String name;
  final String description;

  Example(this.id, this.name, this.description);

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleToJson(this);
}
```