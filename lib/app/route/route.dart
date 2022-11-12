/// pinpin - route
/// Created by xhz on 27/07/2022
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_auth_middleware.dart';
import 'package:pinpin/page/advice/binding.dart';
import 'package:pinpin/page/advice/view.dart';
import 'package:pinpin/page/collections/binding.dart';
import 'package:pinpin/page/collections/view.dart';
import 'package:pinpin/page/edit_profile/binding.dart';
import 'package:pinpin/page/edit_profile/edit_avatar/image_picker.dart';
import 'package:pinpin/page/edit_profile/edit_labels/binding.dart';
import 'package:pinpin/page/edit_profile/edit_labels/view.dart';
import 'package:pinpin/page/edit_profile/edit_personal_profile/binding.dart';
import 'package:pinpin/page/edit_profile/edit_personal_profile/view.dart';
import 'package:pinpin/page/edit_profile/edit_username/binding.dart';
import 'package:pinpin/page/edit_profile/edit_username/view.dart';
import 'package:pinpin/page/edit_profile/view.dart';
import 'package:pinpin/page/guidance/binding.dart';
import 'package:pinpin/page/guidance/view.dart';
import 'package:pinpin/page/home/home_page.dart';
import 'package:pinpin/page/login/login/binding.dart';
import 'package:pinpin/page/login/password/setting/binding.dart';
import 'package:pinpin/page/login/register/binding.dart';
import 'package:pinpin/page/login/welcome_page.dart';
import 'package:pinpin/page/post/binding.dart';
import 'package:pinpin/page/post/view.dart';
import 'package:pinpin/page/pp_detail/bingding.dart';
import 'package:pinpin/page/pp_detail/view.dart';
import 'package:pinpin/page/releases/binding.dart';
import 'package:pinpin/page/releases/view.dart';
import 'package:pinpin/page/unknown_page/view.dart';
import 'package:pinpin/page/login/login/view.dart';
import 'package:pinpin/page/login/password/setting/view.dart';
import 'package:pinpin/page/login/register/view.dart';
import 'package:pinpin/page/profile/binding.dart';
import 'package:pinpin/page/profile/view.dart';
import 'package:pinpin/page/search/binding.dart';
import 'package:pinpin/page/search/view.dart';
import 'route_name.dart';

class Routes {
  static final authMiddleware = RouteAuthMiddleware();
  static final routes = [
    GetPage(
      name: RN.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: RN.welcome,
      page: () => const WelcomePage(),
    ),
    GetPage(
        name: RN.register,
        page: () => const RegisterPage(),
        binding: RegisterBinding()),
    GetPage(
      name: RN.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
        name: RN.passwd_set,
        page: () => const PasswordSetPage(),
        binding: PasswordSetBinding()),
    GetPage(
        name: RN.pp_detail,
        page: () => const PPDetailPage(),
        binding: PPDetailBinding()),
    GetPage(
        name: RN.search,
        page: () => const SearchPage(),
        binding: SearchBinding()),
    GetPage(
        name: RN.collections,
        page: () => const CollectionsPage(),
        binding: CollectionsBinding()),
    GetPage(
        name: RN.advice,
        page: () => const AdvicePage(),
        binding: AdviceBinding()),
    GetPage(
        name: RN.edit_profile,
        page: () => EditProfilePage(),
        binding: EditProfileBinding()),
    GetPage(
        name: RN.releases,
        page: () => const ReleasesPage(),
        binding: ReleasesBinding()),
    GetPage(
        name: RN.guidance,
        page: () => const GuidancePage(),
        binding: GuidanceBinding()),
    GetPage(
        name: RN.edit_personal_profile,
        page: () => EditPersonalProfilePage(),
        binding: EditPersonalProfileBinding()),
    GetPage(
        name: RN.edit_username,
        page: () => EditUsernamePage(),
        binding: EditUsernameBinding()),
    GetPage(
        name: RN.edit_labels,
        page: () => EditLabelsPage(),
        binding: EditLabelsBinding()),
    GetPage(
        name: RN.edit_avatar,
        page: () => const ImagePickerWidget()),
    GetPage(
      name: RN.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
      middlewares: [authMiddleware],
    ),
    GetPage(
      name: RN.post,
      page: () => const PPPostPage(),
      binding: PPPostBinding(),
      middlewares: [authMiddleware],
    ),
  ];
  static final unknown =
      GetPage(name: RN.notFound, page: () => const UnknownRoutePage());
}
