/// pinpin - app_theme
/// Created by xhz on 2022/8/3

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const titleline = TextStyle(
      fontSize: 20,
      decoration: TextDecoration.none,
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontFamily: '.SF UI Display');

  static const headline1 = TextStyle(
      fontSize: 24,
      decoration: TextDecoration.none,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: '.SF UI Display');
  static const headline2 = TextStyle(
      fontSize: 20,
      decoration: TextDecoration.none,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: '.SF UI Display');
  static const headline3 = TextStyle(
      fontSize: 18,
      decoration: TextDecoration.none,
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontFamily: '.SF UI Display');
  static const headline4 = TextStyle(
      fontSize: 16,
      decoration: TextDecoration.none,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: '.SF UI Display');
  static const headline5 = TextStyle(
      fontSize: 15,
      decoration: TextDecoration.none,
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontFamily: '.SF UI Display');
  static const headline6 = TextStyle(
      fontSize: 14,
      decoration: TextDecoration.none,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: '.SF UI Display');
  static const headline7 = TextStyle(
      fontSize: 14,
      decoration: TextDecoration.none,
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontFamily: '.SF UI Display');
  static const headline8 = TextStyle(
      fontSize: 13,
      decoration: TextDecoration.none,
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontFamily: '.SF UI Display');
  static const headline9 = TextStyle(
      fontSize: 12,
      decoration: TextDecoration.none,
      color: Colors.black,
      fontWeight: FontWeight.w300,
      fontFamily: '.SF UI Display');
  static const headline10 = TextStyle(
      fontSize: 11,
      decoration: TextDecoration.none,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: '.SF UI Display');
  static const headline11 = TextStyle(
      fontSize: 11,
      decoration: TextDecoration.none,
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontFamily: '.SF UI Display');

  static const primary = Color(0xFF0076FC);
  static const primary2 = Color(0xFFFEA734);

  static const secondary5 = Color(0xFFE6EDFF);
  static const secondary4 = Color(0xFF005EC8);
  static const secondary3 = Color(0xFF53A3FF);
  static const secondary2 = Color(0xFF34E4AA);
  static const secondary1 = Color(0xFFFF6767);

  static const gray100 = Color(0xFFFFFFFF);
  static const gray95 = Color(0xFFF3F3F3);
  static const gray80 = Color(0xFFCCCCCC);
  static const gray50 = Color(0xFF7E7E7E);
  static const gray30 = Color(0xFF4b4b4b);
  static const gray20 = Color(0xFF343434);
  static const gray0 = Color(0xFF000000);
  static const gray = Color(0xFF001D3E);

  static const lightBackground = Color(0xfff6f6f6);

  static const maskWhite = Color.fromRGBO(255, 255, 255, 0.8);

  static const whiteShadow = BoxShadow(
    offset: Offset(0, 4),
    blurRadius: 25,
    color: Color(0xFFEAEAEA),
  );

  static const shadow = BoxShadow(
    offset: Offset(0, 4),
    blurRadius: 10,
    color: Color.fromRGBO(0, 0, 0, 0.04),
  );

  static const Color banned = Color(0xFFCCCCCC);

  /// A material design text theme with dark glyphs based on San Francisco.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  ///
  /// This theme uses the iOS version of the font names.
  static const TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
        debugLabel: 'blackCupertino displayLarge',
        fontFamily: '.SF UI Display',
        color: Colors.black54,
        decoration: TextDecoration.none),
    displayMedium: TextStyle(
        debugLabel: 'blackCupertino displayMedium',
        fontFamily: '.SF UI Display',
        color: Colors.black54,
        decoration: TextDecoration.none),
    displaySmall: TextStyle(
        debugLabel: 'blackCupertino displaySmall',
        fontFamily: '.SF UI Display',
        color: Colors.black54,
        decoration: TextDecoration.none),
    headlineLarge: TextStyle(
        debugLabel: 'blackCupertino headlineLarge',
        fontFamily: '.SF UI Display',
        color: Colors.black54,
        decoration: TextDecoration.none),
    headlineMedium: TextStyle(
        debugLabel: 'blackCupertino headlineMedium',
        fontFamily: '.SF UI Display',
        color: Colors.black54,
        decoration: TextDecoration.none),
    headlineSmall: TextStyle(
        debugLabel: 'blackCupertino headlineSmall',
        fontFamily: '.SF UI Display',
        color: Colors.black87,
        decoration: TextDecoration.none),
    titleLarge: TextStyle(
        debugLabel: 'blackCupertino titleLarge',
        fontFamily: '.SF UI Display',
        color: Colors.black87,
        decoration: TextDecoration.none),
    titleMedium: TextStyle(
        debugLabel: 'blackCupertino titleMedium',
        fontFamily: '.SF UI Text',
        color: Colors.black87,
        decoration: TextDecoration.none),
    titleSmall: TextStyle(
        debugLabel: 'blackCupertino titleSmall',
        fontFamily: '.SF UI Text',
        color: Colors.black,
        decoration: TextDecoration.none),
    bodyLarge: TextStyle(
        debugLabel: 'blackCupertino bodyLarge',
        fontFamily: '.SF UI Text',
        color: Colors.black87,
        decoration: TextDecoration.none),
    bodyMedium: TextStyle(
        debugLabel: 'blackCupertino bodyMedium',
        fontFamily: '.SF UI Text',
        color: Colors.black87,
        decoration: TextDecoration.none),
    bodySmall: TextStyle(
        debugLabel: 'blackCupertino bodySmall',
        fontFamily: '.SF UI Text',
        color: Colors.black54,
        decoration: TextDecoration.none),
    labelLarge: TextStyle(
        debugLabel: 'blackCupertino labelLarge',
        fontFamily: '.SF UI Text',
        color: Colors.black87,
        decoration: TextDecoration.none),
    labelMedium: TextStyle(
        debugLabel: 'blackCupertino labelMedium',
        fontFamily: '.SF UI Text',
        color: Colors.black,
        decoration: TextDecoration.none),
    labelSmall: TextStyle(
        debugLabel: 'blackCupertino labelSmall',
        fontFamily: '.SF UI Text',
        color: Colors.black,
        decoration: TextDecoration.none),
  );

  /// A material design text theme with light glyphs based on San Francisco.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  ///
  /// This theme uses the iOS version of the font names.
  static const TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
        debugLabel: 'whiteCupertino displayLarge',
        fontFamily: '.SF UI Display',
        color: Colors.white70,
        decoration: TextDecoration.none),
    displayMedium: TextStyle(
        debugLabel: 'whiteCupertino displayMedium',
        fontFamily: '.SF UI Display',
        color: Colors.white70,
        decoration: TextDecoration.none),
    displaySmall: TextStyle(
        debugLabel: 'whiteCupertino displaySmall',
        fontFamily: '.SF UI Display',
        color: Colors.white70,
        decoration: TextDecoration.none),
    headlineLarge: TextStyle(
        debugLabel: 'whiteCupertino headlineLarge',
        fontFamily: '.SF UI Display',
        color: Colors.white70,
        decoration: TextDecoration.none),
    headlineMedium: TextStyle(
        debugLabel: 'whiteCupertino headlineMedium',
        fontFamily: '.SF UI Display',
        color: Colors.white70,
        decoration: TextDecoration.none),
    headlineSmall: TextStyle(
        debugLabel: 'whiteCupertino headlineSmall',
        fontFamily: '.SF UI Display',
        color: Colors.white,
        decoration: TextDecoration.none),
    titleLarge: TextStyle(
        debugLabel: 'whiteCupertino titleLarge',
        fontFamily: '.SF UI Display',
        color: Colors.white,
        decoration: TextDecoration.none),
    titleMedium: TextStyle(
        debugLabel: 'whiteCupertino titleMedium',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        decoration: TextDecoration.none),
    titleSmall: TextStyle(
        debugLabel: 'whiteCupertino titleSmall',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        decoration: TextDecoration.none),
    bodyLarge: TextStyle(
        debugLabel: 'whiteCupertino bodyLarge',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        decoration: TextDecoration.none),
    bodyMedium: TextStyle(
        debugLabel: 'whiteCupertino bodyMedium',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        decoration: TextDecoration.none),
    bodySmall: TextStyle(
        debugLabel: 'whiteCupertino bodySmall',
        fontFamily: '.SF UI Text',
        color: Colors.white70,
        decoration: TextDecoration.none),
    labelLarge: TextStyle(
        debugLabel: 'whiteCupertino labelLarge',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        decoration: TextDecoration.none),
    labelMedium: TextStyle(
        debugLabel: 'whiteCupertino labelMedium',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        decoration: TextDecoration.none),
    labelSmall: TextStyle(
        debugLabel: 'whiteCupertino labelSmall',
        fontFamily: '.SF UI Text',
        color: Colors.white,
        decoration: TextDecoration.none),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: lightBackground,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: primary2,
      secondary: secondary1,
      onSecondary: secondary2,
      error: secondary1,
      onError: secondary2,
      background: Colors.white,
      onBackground: Colors.black,
      surface: gray80,
      onSurface: Colors.black,
    ),
  );
}
