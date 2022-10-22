import 'package:flutter/material.dart';

class AppTheme {
  static const Color mainColor = Color(0xffb74c3a);
  static const MaterialColor kToDark = MaterialColor(
    0xffb74c3a, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: mainColor,  100: mainColor, 200: mainColor,  300: mainColor,
      400: mainColor, 500: mainColor, 600: mainColor, 700: mainColor,
      800: mainColor, 900: mainColor,
    },
  );
  static ThemeData mainTheme() => ThemeData(primarySwatch: kToDark);
}
