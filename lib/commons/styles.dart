import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData themeData = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.pink,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: Colors.black,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    padding: const EdgeInsets.all(8),
    buttonColor: Colors.pink,
    disabledColor: Colors.grey[900],
    splashColor: Colors.pink[400],
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: Colors.transparent,
    shadowColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade900,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: const IconThemeData(color: Colors.pinkAccent),
      unselectedIconTheme: const IconThemeData(color: Colors.grey)),
  cardColor: Colors.grey,
  cardTheme: CardTheme(
    shadowColor: Colors.transparent,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      letterSpacing: 0.15,
    ),
    subtitle2: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 0.1,
    ),
  ),
);

final BoxDecoration boxDecorationWithPinkShadow = BoxDecoration(
  boxShadow: <BoxShadow>[
    BoxShadow(
      color: Colors.pink.withOpacity(0.1),
      blurRadius: 20,
      spreadRadius: 1,
      offset: const Offset(0, 0),
    ),
  ],
);
