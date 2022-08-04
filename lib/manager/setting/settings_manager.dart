/// pinpin - settings_manager
/// Created by xhz on 03/08/2022
import 'package:get/get.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager extends GetxService {
  late final SharedPreferences _sharedPreferences;

  static const supportedLocales = [
    defaultLocale,
    Locale('en'),
  ];

  static const defaultLocale = Locale('zh');

  Future<SettingsManager> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  bool get guideInit => _sharedPreferences.getBool('guide_init') ?? false;

  set guideInit(bool value) => _sharedPreferences.setBool('guide_init', value);

  int get theme => _sharedPreferences.getInt('theme') ?? -1;

  set theme(int value) {
    _sharedPreferences.setInt('theme', value);
  }

  bool get enableHistory => _sharedPreferences.getBool('enable_history') ?? false;

  set enableHistory(bool value) {
    _sharedPreferences.setBool('enable_history', value);
  }

  Locale get locale {
    final code = _sharedPreferences.getString('locale');
    if (null != code) {
      return Locale.fromSubtags(languageCode: code);
    }
    return window.locale;
  }

  set locale(Locale value) {
    Get.updateLocale(value);
    _sharedPreferences.setString('locale', value.languageCode);
  }
}

