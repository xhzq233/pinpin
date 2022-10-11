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

    /// content
    const personDesc = Text(
      "个人简介",
      style: AppTheme.headline4,
      textAlign: TextAlign.left,
    );

    const labels = Text(
      "标签页",
      style: AppTheme.headline4,
      textAlign: TextAlign.left,
    );

    const text = Text(
      "多好玩会晚点海王awful啊文本色废弃物画的图还挺好都挺好挺好好更好地发放我发哇哇哇大发发阿尔法啊发的，而非爱儿阿苏是的污。",
      style: AppTheme.headline9,
      textAlign: TextAlign.left,
    );

    const launchers = Text(
      "我发布的",
      style: AppTheme.headline4,
      textAlign: TextAlign.left,
    );

    const checkAll = SizedBox(
      width: 48,
      height: 17,
      child: Text(
        "查看全部",
        style: AppTheme.headline9,
        textAlign: TextAlign.left,
      ),
    );

    final rightArrow = Image.asset(
      AppAssets.arrow_right,
      height: 28,
      fit: BoxFit.fitHeight,
    );

    final box =
        Row(mainAxisSize: MainAxisSize.max, children: [checkAll, rightArrow]);

    final lock = Image.asset(
      AppAssets.lock,
      height: 20,
      fit: BoxFit.fitHeight,
    );

    const all_can_see = Text(
      "所有人可见",
      style: AppTheme.headline10,
      textAlign: TextAlign.left,
    );

    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          const SliverPersistentHeader(
            pinned: true,
            delegate: PinPinPersonSliverHeaderDelegate(),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [personDesc],
                ),
                Container(
                    width: 354,
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: text),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [labels],
                ),
                Wrap(
                  spacing: 8.0, // 主轴(水平)方向间距
                  runSpacing: 0.5, // 纵轴（垂直）方向间距
                  alignment: WrapAlignment.start, //沿主轴方向居中
                  children: <Widget>[
                    const Chip(
                      labelStyle:
                          TextStyle(color: Color(0xFF0076FC), fontSize: 12),
                      label: Text("白羊座"),
                    ),
                    const Chip(
                      labelStyle:
                          TextStyle(color: Color(0xFF0076FC), fontSize: 12),
                      label: Text('二次元'),
                    ),
                    const Chip(
                      labelStyle:
                          TextStyle(color: Color(0xFF0076FC), fontSize: 12),
                      label: Text('intp'),
                    ),
                    const Chip(
                      labelStyle:
                          TextStyle(color: Color(0xFF0076FC), fontSize: 12),
                      label: Text('巴拉拉'),
                    ),
                    const Chip(
                      labelStyle:
                          TextStyle(color: Color(0xFF0076FC), fontSize: 12),
                      label: Text('巴拉巴拉'),
                    ),
                    const Chip(
                      labelStyle:
                          TextStyle(color: Color(0xFF0076FC), fontSize: 12),
                      label: Text('巴拉拉巴拉拉'),
                    ),
                    const Chip(
                      labelStyle:
                          TextStyle(color: Color(0xFF0076FC), fontSize: 12),
                      label: Text('巴拉巴拉'),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: launchers,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: box,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [lock, all_can_see],
                    )
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: 18),
          ),
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
