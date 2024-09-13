import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'light_colors.dart';
part 'light_fonts.dart';

final lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  textTheme: _lightFonts,
  colorScheme: const ColorScheme.light().copyWith(
    primary: _blueDayLight,
    onPrimary: _white,
    surface: _white,
    onSurface: _black,
    secondary: _blueDaySecondary,
    onSecondary: _lightGray,
    error: _redError,
    tertiary: _blueDayDrawerBackground,
    tertiaryContainer: _blueDayTransparentTertiary,
    onTertiary: _blueDayTransparent,
    primaryContainer: _purpleLightPrimaryVariant,
    secondaryContainer: _orangeLightSecondaryVariant,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: _lightGray,
    titleTextStyle: TextStyle(color: _black, fontWeight: FontWeight.bold, fontSize: 18),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: _lightGray,
      systemNavigationBarColor: _lightGray,
      statusBarBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(color: _black),
  ),
  scaffoldBackgroundColor: _white,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: _blueDayLight),
  ),
  dividerTheme: const DividerThemeData(color: _black),
  dialogTheme: const DialogTheme(
    titleTextStyle: TextStyle(color: _black, fontWeight: FontWeight.bold, fontSize: 18),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: _lightGray,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      side: BorderSide(color: _blueDayLight),
    ),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: _blueDaySecondary,
    behavior: SnackBarBehavior.floating,
  ),
);
