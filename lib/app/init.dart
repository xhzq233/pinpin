/// pinpin - init
/// Created by xhz on 3/10/23

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pinpin/manager/account_manager/account_manager.dart';
import 'package:get/get.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/manager/api/client.dart';
import 'package:pinpin/manager/db_manager/database.dart';
import 'package:pinpin/manager/setting/settings_manager.dart';
import 'package:util/util.dart';

class Config {
  const Config._();

  static init() async {
    WidgetsFlutterBinding.ensureInitialized(); //app运行前，先和engine层通信(指注册好绘画手势的监听器等)
    // debugRepaintRainbowEnabled = true;
    await Get.putAsync(() => AccountManager().init());
    final accountManager = Get.find<AccountManager>();

    Get.put<PPNetWorkInterface>(
      initHttp(
        deviceName: 'XHZQ',
        accountGetter: () => accountManager.current,
        accountUpdater: (data) => accountManager.addAccount(data),
        toaster: toast,
      ),
    );
    await SettingsManager.init();
    if (!kIsWeb) {
      // await initDB();
      await Get.putAsync(() => $FloorPPDatabase.databaseBuilder('pinpin.db').build());
    }
  }
}
