import 'package:flutter/material.dart';

part 'dark_colors.dart';
part 'dark_fonts.dart';

final darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  textTheme: _darkFonts,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: _blueNightMedium,
    onPrimary: _white,
    surface: _black,
    onSurface: _white,
    secondary: _blueNightSecondary,
    onSecondary: _darkGray,
    error: _redError,
    tertiary: _blueNightDrawerBackground,
    tertiaryContainer: _blueNightDrawerBackground,
    onTertiary: _blueNightTransparent,
    primaryContainer: _purpleNightPrimaryVariant,
    secondaryContainer: _orangeNightSecondaryVariant,
  ),

  /// We use the schema to overwrite custom widgets
  /// Other way is to override every widget theme:

/*  appBarTheme: const AppBarTheme(
    backgroundColor: _darkGray,
    titleTextStyle: TextStyle(color: _white, fontWeight: FontWeight.bold, fontSize: 18),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: _darkGray,
      systemNavigationBarColor: _darkGray,
      statusBarBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(color: _white),
  ),
  scaffoldBackgroundColor: _black,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: _blueNightLight),
  ),
  dividerTheme: const DividerThemeData(
    color: _white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: _white,
      backgroundColor: _blueNightMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: _blueNightMedium,
        width: 2,
      ),
    ),
  ),
  dialogTheme: const DialogTheme(
    titleTextStyle: TextStyle(color: _white, fontWeight: FontWeight.bold, fontSize: 18),
  ),

  popupMenuTheme: const PopupMenuThemeData(
    color: _darkGray,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      side: BorderSide(color: _blueNightMedium),
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: _blueNightSecondary,
    behavior: SnackBarBehavior.floating,
  ),*/
);
