import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/component/header/home_sliver_header.dart';
import 'package:pinpin/component/header/person_sliver_header.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';

import '../../app/assets/name.dart';
import '../../app/theme/app_theme.dart';
import '../../component/header/sliver_header_delegate.dart';
import '../../component/search_bar/search_bar.dart';
import '../../component/stateful_button/pp_image_button.dart';
import '../../util/clipper.dart';
import 'controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 页面布局逻辑
    final controller = Get.find<ProfileController>(); //Get拿到controller里的变量

    final pinpin = PinPin(
        pinpinId: 1,
        type: 2,
        label: 3,
        title: "hello world",
        deadline: DateTime.now(),
        demandingNum: 100,
        nowNum: 10,
        ownerEmail: "U202013777",
        updatedAt: 555,
        isFollowed: true);
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          const SliverPersistentHeader(
            pinned: true,
            delegate: PinPinPersonSliverHeaderDelegate(),
          )
        ];
      },
      body: ListView.builder(
          itemCount: 100,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return PPHomeCardView(pp: pinpin);
          }).paddingSymmetric(horizontal: 18),
    ));
  }
}
