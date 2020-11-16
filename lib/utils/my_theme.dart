import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(8, 45, 74, .1),
  100: Color.fromRGBO(8, 45, 74, .2),
  200: Color.fromRGBO(8, 45, 74, .3),
  300: Color.fromRGBO(8, 45, 74, .4),
  400: Color.fromRGBO(8, 45, 74, .5),
  500: Color.fromRGBO(8, 45, 74, .6),
  600: Color.fromRGBO(8, 45, 74, .7),
  700: Color.fromRGBO(8, 45, 74, .8),
  800: Color.fromRGBO(8, 45, 74, .9),
};

MaterialColor customPrimaryColor = MaterialColor(0xFF1D1D38, color);
Color customAccentColor = Color(0xFFF2EFF5);

final my_theme = ThemeData(
  primarySwatch: customPrimaryColor,
  accentColor: customAccentColor,
  errorColor: Colors.redAccent,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'ProximaNova',
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 25.0,
      fontFamily: 'ProximaNova',
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: const TextStyle(fontSize: 16.0),
  ),
);
