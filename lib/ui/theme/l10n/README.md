# TRANSLATIONS  

> Oficial Docs: https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization

Add `pubspec.yaml` dependencies:  
```bash
flutter pub add flutter_localizations --sdk=flutter
flutter pub add intl:any
```
```yaml  
 flutter_localizations: 
	 sdk: flutter 
 intl: any  
```  
Create config file `l10n.yaml` in application root:  
```yaml  
arb-dir: lib/ui/theme/l10n # path to translation files  
template-arb-file: app_en.arb # default localization  
output-localization-file: app_localizations.dart # target to compile files  
```  
  
In the `arb-dir` path we'll add every translation file we need  
```  
lib/  
└── ui/  
	 └── l10n/ 
		 ├── app_en.arb 
		 └── app_es.arb
```
It's mandatory to have all the _strings_ in the `default-arb-file` we defined in the `l10n.yaml`, if there is no reference in other files and we call them the default will be used instead.

Define localizations for the app:
```dart
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
  ],
  ...
);
```

Example
> Make sure you're importing the correct package.

_app_en.arb_
```json
{  
  "exampleTranslation1": "Example Translation1",  
  "exampleTranslation2": "Example Translation2"  
}
```
_app_es.arb_
```json
{  
  "exampleTranslation1": "Ejemplo Traducción1",  
  "exampleTranslation2": "Ejemplo Traducción2"  
}
```

```dart
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

