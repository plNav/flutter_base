
# UI Layer

The **UI** directory handles all components related to the user interface, including screen layouts, routing, styling, and reusable widgets. It follows a modular structure that promotes code reusability and maintainability.

---

## Table of Contents

- [Overview](#overview)
- [Routing](#Navigation)
- [Translations](#translations)
- [Theme Styling](#theme-styling)

---

## Overview

The **UI** folder contains the following subdirectories:

- **bloc/**: State management using Bloc/Cubit for handling UI state. This folder is responsible for dependency injection, and it has its own dedicated README file inside.
- **navigation/**: Manages routing logic and screen constant definitions.
- **screen/**: Holds the UI's main components, such as pages and screens that are not meant to be reusable.
- **theme/**: Contains configurations for `styling`, including light and dark themes, as well as `translation` configurations.
- **widget/**: Contains reusable UI components that can be shared across different screens.


```
ui/
├── bloc/           # State management and Dependeny Injection - Own README file.
├── navigation/     # Routing logic, screen constant definitions.
├── screen/         # UI main components, not reusable.
├── theme/          # Styling and Translation configurations.
└── widget/         # Reusable components.
```

---

## Navigation

The **navigation/** directory manages the routing logic of the app. It contains the following key files:

- **paths.dart**: Defines the various screen paths as constant values, providing a central place to manage route names.
- **routes.dart**: Maps paths to widget builders, enabling navigation between screens. This file also supports Bloc dependency injection for the screens.
  Routing

Routing defines how different screens are connected and allows for navigation between them.

```
Navigator.of(context).pushNamed(path_constant);
```

### Example: Setting Up Routes

To define the routes for your app:

```
MaterialApp(
routes: Routes.routes,
initialRoute: splash,
...
);
```

> The `routes.dart` file is also used for injecting BLoCs into screens as needed.

```dart
class Routes {
  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (_) => const Text('TODO: Splash Screen'),
      login: (context) => BlocProvider(
            create: (context) => LoginBloc(
              loginService: LoginService(loginRepository: context.read<ILoginRepository>()),
            ),
            child: const LoginScreen(),
          ),
    };
  }
}
```
---

## Screen

The **screen/** directory holds the primary UI components, such as the app's screens or pages. These components represent major views and are not reusable. Each screen typically corresponds to a specific route and may include business logic and state management through Blocs.


## Translations

Flutter supports internationalization (i18n), enabling your app to support multiple languages. Translation files are defined in `.arb` files, and Flutter's built-in localization system is used to load and manage these translations.

### Official Docs
- [Flutter Internationalization](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)

### Setup in `pubspec.yaml`

Add the necessary dependencies:

```bash
flutter pub add flutter_localizations --sdk=flutter
flutter pub add intl:any
```

```yaml  
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: any  
```

### Configuring the Localization Files

Create a `l10n.yaml` file in your project root for configuring localization:

```yaml
arb-dir: lib/ui/theme/l10n  # Path to the translation files
template-arb-file: app_en.arb  # Default localization
output-localization-file: app_localizations.dart  # Generated localization file
```

### Example Localization Files

- **app_en.arb** (English)

```json
{
  "exampleTranslation1": "Example Translation 1",
  "exampleTranslation2": "Example Translation 2"
}
```

- **app_es.arb** (Spanish)

```json
{
  "exampleTranslation1": "Ejemplo Traducción 1",
  "exampleTranslation2": "Ejemplo Traducción 2"
}
```

- **app_de.arb** (German)

```json
{
  "exampleTranslation1": "Beispielübersetzung 1",
  "exampleTranslation2": "Beispielübersetzung 2"
}
```


### Example: Using Translations in Code

```
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations translator = AppLocalizations.of(context)!;
    final String translatedString = translator.exampleTranslation1;
    ...
  }
}
```
> ⚠ Somethimes the IDE cannot autoimport the package so write it by hand
```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
```


### Defining Localizations in Your App

```
MaterialApp(
  localizationsDelegates: [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: [
    Locale('en'), // English
    Locale('es'), // Spanish
    Locale('de'), // German
  ],
...
);
```

---

## Theme Styling

Styling in Flutter is managed through themes, allowing you to define consistent colors, text styles, and widget appearances across your app.

### Official Docs
- [Flutter Theme Styling](https://docs.flutter.dev/cookbook/design/themes)

### Key Files:

- **colors.dart**: Defines constant color values used across light and dark themes. These constants should not be used directly in the code but instead referenced in the themes.
- **dark_theme.dart & light_theme.dart**: Contains the theme definitions for light and dark modes. These themes include color schemes, text styles, and default widget appearances.

### Example: Accessing Colors from the Theme

```dart
final Color themeColor = Theme.of(context).colorScheme.primary;
```

### Defining Themes in Your App

```
MaterialApp(
  themeMode: ThemeMode.dark, // Default theme mode
  theme: lightTheme,         // Light theme
  darkTheme: darkTheme,      // Dark theme
...
);
```
---
