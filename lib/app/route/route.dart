/// pinpin - route
/// Created by xhz on 27/07/2022
import 'package:get/get.dart';
import 'package:pinpin/page/home/view.dart';
import 'package:pinpin/page/login/binding.dart';
import 'package:pinpin/page/login/view.dart';
import 'route_name.dart';

class Routes {
  static final routes = [
    GetPage(
        name: RN.home,
        page: () => const HomePage(),
    ),
    GetPage(
      name: RN.login,
      page: () => const LoginPage(),
      binding: LoginBinding()
    ),
  ];
}