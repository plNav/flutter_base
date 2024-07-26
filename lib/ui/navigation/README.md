# ROUTING

- paths.dart
Defines the different screen paths as constant values

- routes.dart
Links paths with widget builders, so we can call named routes from code
`Navigator.of(context).pushNamed(**path_constant**)`

> routes.dart is also used to inject blocs in the screen.

Define routes for the app:
```dart
MaterialApp(
  routes: Routes.routes,
  initialRoute: splash,
  ...
);
```