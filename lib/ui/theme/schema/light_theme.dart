import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:baccus_kitchen/ui/theme/schema/colors.dart';

final lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: lightGray,
    titleTextStyle: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 18),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: lightGray,
      systemNavigationBarColor: lightGray,
      statusBarBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(color: black),
  ),
  scaffoldBackgroundColor: white,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: blueDayLight),
  ),
  dividerTheme: const DividerThemeData(color: black),
  dialogTheme: const DialogTheme(
    titleTextStyle: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 18),
  ),
  colorScheme: const ColorScheme.light().copyWith(
    primary: blueDayLight,
    onPrimary: white,
    surface: white,
    onSurface: black,
    secondary: blueDaySecondary,
    onSecondary: lightGray,
    error: redError,
    onBackground: darkGray,
    tertiary: blueDayDrawerBackground,
    tertiaryContainer: blueDayTransparentTertiary,
    onTertiary: blueDayTransparent,
    primaryContainer: purpleLightPrimaryVariant,
    secondaryContainer: orangeLightSecondaryVariant,
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: lightGray,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      side: BorderSide(color: blueDayLight),
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
      backgroundColor: blueDaySecondary, behavior: SnackBarBehavior.floating),
);
