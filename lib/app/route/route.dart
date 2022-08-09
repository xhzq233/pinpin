/// pinpin - route
/// Created by xhz on 27/07/2022
import 'package:get/get.dart';
import 'package:pinpin/page/home/view.dart';
import 'package:pinpin/page/login/binding.dart';
import 'package:pinpin/page/login/view.dart';
import 'package:pinpin/page/pp_detail/bingding.dart';
import 'package:pinpin/page/pp_detail/view.dart';
import 'package:pinpin/page/unknown_page/view.dart';
import 'route_name.dart';

class Routes {
  static final routes = [
    GetPage(
      name: RN.home,
      page: () => const HomePage(),
    ),
    GetPage(name: RN.login, page: () => const LoginPage(), binding: LoginBinding()),
    GetPage(name: RN.pp_detail, page: () => const PPDetailPage(), binding: PPDetailBinding()),
  ];
  static final unknown = GetPage(name: RN.notFound, page: () => const UnknownRoutePage());
}