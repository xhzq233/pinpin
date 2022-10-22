/// pinpin - route_auth_middleware
/// Created by xhz on 27/07/2022

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/i18n/i18n_names.dart';
import 'package:pinpin/manager/account_manager/account_manager.dart';
import 'package:pinpin/app/route/route_name.dart';

class RouteAuthMiddleware extends GetMiddleware {
  RouteAuthMiddleware() : super(priority: 1);

  @override
  RouteSettings? redirect(String? route) {
    if (Get.find<AccountManager>().isNotEmpty) {
      return null;
    }
    Get.snackbar(I18n.notice.tr, "请先登录APP");

    return const RouteSettings(name: RN.login);
  }
}
