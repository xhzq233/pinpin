import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/i18n/i18n_translations.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/manager/account_manager/account_manager.dart';
import 'package:pinpin/manager/api/http_client.dart';
import 'package:pinpin/manager/db_manager/pinpin_db.dart';
import 'package:pinpin/app/route/route.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/i18n/i18n_names.dart';
import 'package:pinpin/manager/setting/settings_manager.dart';

void main() async {
  await _init();
  runApp(const PPApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized(); //app运行前，先和engine层通信(指注册好绘画手势的监听器等)
  // debugRepaintRainbowEnabled = true;
  await Get.putAsync(() => AccountManager().init());
  Get.put(
    PPHttp.init(
      deviceName: 'XHZQ',
      accountGetter: () => Get.find<AccountManager>().current,
      accountUpdater: (data) => Get.find<AccountManager>().updateAccount(data),
    ),
  );
  await Get.putAsync(() => SettingsManager().init());
  if (!kIsWeb) {
    await Get.putAsync(() => PPDBManager().init());
  }
}

class PPApp extends StatelessWidget {
  const PPApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.cupertino,
      enableLog: true,
      debugShowCheckedModeBanner: false,
      title: I18n.title.tr,
      translations: I18nTranslations(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: SettingsManager.supportedLocales,
      fallbackLocale: SettingsManager.defaultLocale,
      getPages: Routes.routes,
      locale: Get.find<SettingsManager>().locale,
      theme: AppTheme.lightTheme,
      initialRoute: Get.find<AccountManager>().isEmpty ? RN.welcome : RN.home,
      unknownRoute: Routes.unknown,
    );
  }
}
