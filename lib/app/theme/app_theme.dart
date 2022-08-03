/// pinpin - app_theme 
/// Created by xhz on 2022/8/3

import 'package:flutter/material.dart';

class AppTheme {

  /// A material design text theme with dark glyphs based on San Francisco.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  ///
  /// This theme uses the iOS version of the font names.
  static const TextTheme lightTextTheme = TextTheme(
    displayLarge : TextStyle(debugLabel: 'blackCupertino displayLarge', fontFamily: '.SF UI Display', color: Colors.black54, decoration: TextDecoration.none),
    displayMedium : TextStyle(debugLabel: 'blackCupertino displayMedium', fontFamily: '.SF UI Display', color: Colors.black54, decoration: TextDecoration.none),
    displaySmall : TextStyle(debugLabel: 'blackCupertino displaySmall', fontFamily: '.SF UI Display', color: Colors.black54, decoration: TextDecoration.none),
    headlineLarge : TextStyle(debugLabel: 'blackCupertino headlineLarge', fontFamily: '.SF UI Display', color: Colors.black54, decoration: TextDecoration.none),
    headlineMedium : TextStyle(debugLabel: 'blackCupertino headlineMedium', fontFamily: '.SF UI Display', color: Colors.black54, decoration: TextDecoration.none),
    headlineSmall : TextStyle(debugLabel: 'blackCupertino headlineSmall', fontFamily: '.SF UI Display', color: Colors.black87, decoration: TextDecoration.none),
    titleLarge : TextStyle(debugLabel: 'blackCupertino titleLarge', fontFamily: '.SF UI Display', color: Colors.black87, decoration: TextDecoration.none),
    titleMedium : TextStyle(debugLabel: 'blackCupertino titleMedium', fontFamily: '.SF UI Text', color: Colors.black87, decoration: TextDecoration.none),
    titleSmall : TextStyle(debugLabel: 'blackCupertino titleSmall', fontFamily: '.SF UI Text', color: Colors.black,   decoration: TextDecoration.none),
    bodyLarge : TextStyle(debugLabel: 'blackCupertino bodyLarge', fontFamily: '.SF UI Text', color: Colors.black87, decoration: TextDecoration.none),
    bodyMedium : TextStyle(debugLabel: 'blackCupertino bodyMedium', fontFamily: '.SF UI Text', color: Colors.black87, decoration: TextDecoration.none),
    bodySmall   : TextStyle(debugLabel: 'blackCupertino bodySmall',   fontFamily: '.SF UI Text', color: Colors.black54, decoration: TextDecoration.none),
    labelLarge    : TextStyle(debugLabel: 'blackCupertino labelLarge',    fontFamily: '.SF UI Text', color: Colors.black87, decoration: TextDecoration.none),
    labelMedium  : TextStyle(debugLabel: 'blackCupertino labelMedium',  fontFamily: '.SF UI Text', color: Colors.black,   decoration: TextDecoration.none),
    labelSmall  : TextStyle(debugLabel: 'blackCupertino labelSmall',  fontFamily: '.SF UI Text', color: Colors.black,   decoration: TextDecoration.none),
  );

  /// A material design text theme with light glyphs based on San Francisco.
  ///
  /// This [TextTheme] provides color but not geometry (font size, weight, etc).
  ///
  /// This theme uses the iOS version of the font names.
  static const TextTheme darkTextTheme = TextTheme(
    displayLarge : TextStyle(debugLabel: 'whiteCupertino displayLarge', fontFamily: '.SF UI Display', color: Colors.white70, decoration: TextDecoration.none),
    displayMedium : TextStyle(debugLabel: 'whiteCupertino displayMedium', fontFamily: '.SF UI Display', color: Colors.white70, decoration: TextDecoration.none),
    displaySmall : TextStyle(debugLabel: 'whiteCupertino displaySmall', fontFamily: '.SF UI Display', color: Colors.white70, decoration: TextDecoration.none),
    headlineLarge : TextStyle(debugLabel: 'whiteCupertino headlineLarge', fontFamily: '.SF UI Display', color: Colors.white70, decoration: TextDecoration.none),
    headlineMedium : TextStyle(debugLabel: 'whiteCupertino headlineMedium', fontFamily: '.SF UI Display', color: Colors.white70, decoration: TextDecoration.none),
    headlineSmall : TextStyle(debugLabel: 'whiteCupertino headlineSmall', fontFamily: '.SF UI Display', color: Colors.white,   decoration: TextDecoration.none),
    titleLarge : TextStyle(debugLabel: 'whiteCupertino titleLarge', fontFamily: '.SF UI Display', color: Colors.white,   decoration: TextDecoration.none),
    titleMedium : TextStyle(debugLabel: 'whiteCupertino titleMedium', fontFamily: '.SF UI Text', color: Colors.white,   decoration: TextDecoration.none),
    titleSmall   : TextStyle(debugLabel: 'whiteCupertino titleSmall',   fontFamily: '.SF UI Text', color: Colors.white, decoration: TextDecoration.none),
    bodyLarge : TextStyle(debugLabel: 'whiteCupertino bodyLarge', fontFamily: '.SF UI Text', color: Colors.white,   decoration: TextDecoration.none),
    bodyMedium : TextStyle(debugLabel: 'whiteCupertino bodyMedium', fontFamily: '.SF UI Text', color: Colors.white,   decoration: TextDecoration.none),
    bodySmall    : TextStyle(debugLabel: 'whiteCupertino bodySmall',    fontFamily: '.SF UI Text', color: Colors.white70,   decoration: TextDecoration.none),
    labelLarge : TextStyle(debugLabel: 'whiteCupertino labelLarge', fontFamily: '.SF UI Text', color: Colors.white,   decoration: TextDecoration.none),
    labelMedium  : TextStyle(debugLabel: 'whiteCupertino labelMedium',  fontFamily: '.SF UI Text', color: Colors.white,   decoration: TextDecoration.none),
    labelSmall  : TextStyle(debugLabel: 'whiteCupertino labelSmall',  fontFamily: '.SF UI Text', color: Colors.white,   decoration: TextDecoration.none),
  );

}