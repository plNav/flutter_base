import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:baccus_kitchen/ui/theme/schema/colors.dart';

final darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: darkGray,
    titleTextStyle: TextStyle(color: lightGray, fontWeight: FontWeight.bold, fontSize: 18),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: darkGray,
      systemNavigationBarColor: darkGray,
      statusBarBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(color: lightGray),
  ),
  scaffoldBackgroundColor: black,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: blueNightLight),
  ),
  dividerTheme: const DividerThemeData(
    color: lightGray,
  ),
  //inputDecorationTheme not implemented in lightMode.
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: blueNightMedium,
        width: 2,
      ),
    ),
  ),

  dialogTheme: const DialogTheme(
    titleTextStyle: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 18),
  ),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: blueNightMedium,
    onPrimary: white,
    surface: black,
    onSurface: white,
    secondary: blueNightSecondary,
    onSecondary: darkGray,
    error: redError,
    onBackground: lightGray,
    tertiary: blueNightDrawerBackground,
    tertiaryContainer: blueNightDrawerBackground,
    onTertiary: blueNightTransparent,
    primaryContainer: purpleNightPrimaryVariant,
    secondaryContainer: orangeNightSecondaryVariant,
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: darkGray,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      side: BorderSide(color: blueNightMedium),
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
      backgroundColor: blueNightSecondary, behavior: SnackBarBehavior.floating),
);
