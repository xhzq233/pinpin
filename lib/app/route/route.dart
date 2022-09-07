/// pinpin - route
/// Created by xhz on 27/07/2022
import 'package:get/get.dart';
import 'package:pinpin/page/home/view.dart';
import 'package:pinpin/page/login/login/binding.dart';
import 'package:pinpin/page/login/password/setting/binding.dart';
import 'package:pinpin/page/login/register/binding.dart';
import 'package:pinpin/page/login/welcome_page.dart';
import 'package:pinpin/page/pp_detail/bingding.dart';
import 'package:pinpin/page/pp_detail/view.dart';
import 'package:pinpin/page/unknown_page/view.dart';
import '../../page/login/login/view.dart';
import '../../page/login/password/setting/view.dart';
import '../../page/login/register/view.dart';
import '../../page/login/verify/view.dart';
import 'route_name.dart';

class Routes {
  static final routes = [
    GetPage(
      name: RN.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: RN.welcome,
      page: () => const WelcomePage(),
    ),
    GetPage(name: RN.register, page: () => const RegisterPage(), binding: RegisterBinding()),
    GetPage(
      name: RN.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(name: RN.passwd_set, page: () => const PasswordSetPage(),binding: PasswordSetBinding()),
    GetPage(name: RN.verify, page: () => const VerifyPage()),
    GetPage(name: RN.pp_detail, page: () => const PPDetailPage(), binding: PPDetailBinding()),
  ];
  static final unknown = GetPage(name: RN.notFound, page: () => const UnknownRoutePage());
}
