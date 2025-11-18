import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF005451),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF005451),
      secondary: Colors.white,
    ),
    useMaterial3: true,
    fontFamily: 'Roboto', // Set default font family for entire app
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'LeagueGothic',
        fontSize: 37,
        color: const Color(0xFF005451),
      ),
      displayMedium: TextStyle(
        fontFamily: 'LeagueGothic',
        fontWeight: FontWeight.w400,
        fontSize: 20,
        color: const Color(0xFF005451),
      ),
      titleLarge: TextStyle( // Used by AppBar
        fontFamily: 'LeagueGothic',
        fontWeight: FontWeight.w400,
        fontSize: 37, // Changed from 18 to 37px
        height: 24 / 37, // 24px line-height / 37px font-size
        letterSpacing: -0.2, // -0.2px letter spacing
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'LeagueGothic',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'LeagueGothic',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Colors.black,
      ),
      labelLarge: TextStyle( // Used by buttons
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.white,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF005451),
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontFamily: 'LeagueGothic',
        fontWeight: FontWeight.w400,
        fontSize: 30,
        color: Colors.white,
      ),
    ),

  );
}