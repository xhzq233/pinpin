import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/init.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/manager/account_manager/account_manager.dart';
import 'package:pinpin/app/route/route.dart';
import 'package:pinpin/app/route/route_name.dart';

void main() async {
  await Config.init();

  runApp(
    GetMaterialApp(
      defaultTransition: Transition.cupertino,
      enableLog: true,
      // title: I18n.title.tr,
      title: '拼拼',
      // translations: I18nTranslations(),
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: SettingsManager.supportedLocales,
      // fallbackLocale: SettingsManager.defaultLocale,
      getPages: Routes.routes,
      // locale: SettingsManager.locale,
      theme: AppTheme.lightTheme,
      initialRoute: Get.find<AccountManager>().isEmpty ? RN.welcome : RN.home,
      unknownRoute: Routes.unknown,

      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      // checkerboardOffscreenLayers: true,
    ),
  );
}
