import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData MyDarkThem = ThemeData(
    scaffoldBackgroundColor: HexColor('333739'),
    fontFamily: 'Jannah',
    primaryColor: Colors.blue,
    primarySwatch: Colors.lightBlue,
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      elevation: 0.0,
      color: HexColor('333739'),
      titleSpacing: 20.0,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
    textTheme: TextTheme(
        bodyText1: TextStyle(
      fontSize: 18.0,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    )));

ThemeData MyLigthThem = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Jannah',
    primaryColor: Colors.blue,
    primarySwatch: Colors.lightBlue,
    appBarTheme: AppBarTheme(
        backwardsCompatibility: true,
        elevation: 0.0,
        color: Colors.white,
        titleSpacing: 20.0,
        titleTextStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          // color: Colors.black,
        ),
        actionsIconTheme: IconThemeData(color: Colors.black)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue,
      elevation: 20.0,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
    textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
        bodyText2: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey[600],
        )));
