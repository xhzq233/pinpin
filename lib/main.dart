import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/i18n/i18n_translations.dart';
import 'package:pinpin/manager/account_manager/account_manager.dart';
import 'package:pinpin/manager/api/http_client.dart';
import 'package:pinpin/manager/db_manager/pinpin_db.dart';
import 'package:pinpin/app/route/route.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/i18n/i18n_names.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => AccountManager().init());
  Get.put(PPHttp.init(
      deviceName: 'XHZQ',
      accountGetter: () => Get.find<AccountManager>().current,
      accountUpdater: (data) => Get.find<AccountManager>().updateAccount(data)));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      debugShowCheckedModeBanner: false,
      title: I18n.title.tr,
      translations: I18nTranslations(),
      supportedLocales: const [
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
      fallbackLocale: const Locale('zh', 'CN'),
      getPages: Routes.routes,
      locale: Get.deviceLocale,
      theme: ThemeData(),
      initialRoute: Get.find<AccountManager>().isEmpty ? RN.home : RN.home,
    );
  }
}
