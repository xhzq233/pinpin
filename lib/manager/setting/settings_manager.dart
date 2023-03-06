/// pinpin - settings_manager
/// Created by xhz on 03/08/2022
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  const SettingsManager._();

  static late final SharedPreferences _sharedPreferences;

  static const supportedLocales = [
    defaultLocale,
    // Locale('en'),
  ];

  static const defaultLocale = Locale('zh');

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setStatusBar(themeModeToBrightness(theme));
  }

  static bool get guideInit => _sharedPreferences.getBool('guide_init') ?? false;

  static set guideInit(bool value) => _sharedPreferences.setBool('guide_init', value);

  static int get theme => _sharedPreferences.getInt('theme') ?? ThemeMode.dark.index;

  static Brightness themeModeToBrightness(int value) {
    if (value == ThemeMode.dark.index) {
      return Brightness.dark;
    } else if (value == ThemeMode.light.index) {
      return Brightness.light;
    } else {
      return SchedulerBinding.instance.window.platformBrightness;
    }
  }

  static set theme(int value) {
    _sharedPreferences.setInt('theme', value);
    setStatusBar(themeModeToBrightness(value));
  }

  static setStatusBar(Brightness brightness) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: brightness,
      ),
    );
  }

  static bool get enableHistory => _sharedPreferences.getBool('enable_history') ?? false;

  static set enableHistory(bool value) {
    _sharedPreferences.setBool('enable_history', value);
  }

  static Locale get locale {
    final code = _sharedPreferences.getString('locale');
    if (null != code) {
      return Locale.fromSubtags(languageCode: code);
    }
    print(window.locale);
    return window.locale;
  }

  static set locale(Locale value) {
    Get.updateLocale(value);
    _sharedPreferences.setString('locale', value.languageCode);
  }

  static int get rememberPasswd => _sharedPreferences.getInt('rememberPasswd') ?? -1;

  static set rememberPasswd(int value) {
    _sharedPreferences.setInt('rememberPasswd', value);
  }
}
