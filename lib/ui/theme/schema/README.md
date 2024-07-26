# THEME STYLE

> Oficial Docs: https://docs.flutter.dev/cookbook/design/themes

- colors.dart
Defines constant colors to use in themes, do not use this constants directly on the code.

- dark & light theme .dart
Classes that has all the widgets with it's default colors, also we have the *colorScheme* that
can be used in code to reuse the colors (We'll need the context)

```dart
  final Color themeColor = Theme.of(context).colorScheme.primary;
```

Define themes for the app:
```dart
MaterialApp(
  themeMode: ThemeMode.dark, // Default theme
  theme: lightTheme,      
  darkTheme: darkTheme,
  ...
);
```