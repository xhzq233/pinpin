import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/person_sliver_header.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';

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
      maxLines: null,
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

    final lock = Image.asset(
      AppAssets.lock,
      height: 14.5,
      fit: BoxFit.fitHeight,
    );

    const all_can_see = Text(
      "所有人可见",
      style: AppTheme.headline10,
      textAlign: TextAlign.left,
    );

    final myPosts = Row(
      mainAxisSize: MainAxisSize.max,
      children: [launchers, const Spacer(), checkAll, rightArrow],
    );

    const myLabels = ['白羊座', '二次元', 'intp', '巴拉拉', 'lgbt', 'lgbtq', '巴拉拉'];

    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          const SliverPersistentHeader(
            pinned: true,
            delegate: PinPinPersonSliverHeaderDelegate(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  personDesc,
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: text,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: labels,
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Wrap(
                            spacing: 10, // 主轴(水平)方向间距
                            runSpacing: 10, // 纵轴（垂直）方向间距
                            alignment: WrapAlignment.start, //沿主轴方向居中
                            children: myLabels
                                .map((e) => SizedBox(
                                      height: 21,
                                      child: PPCustomCapsuleButton(
                                        background: AppTheme.secondary5,
                                        child: Text(
                                          e,
                                          style: AppTheme.headline9.copyWith(color: AppTheme.primary),
                                        ),
                                      ),
                                    ))
                                .toList()),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 0.5),
                    child: myPosts,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [lock, all_can_see],
                  ),
                ],
              ),
            ),
          ),
        ];
      },
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          itemCount: 100,
          prototypeItem: PPHomeCardView(
            pp: pinpin,
          ).paddingOnly(bottom: 8), //prototype
          itemBuilder: (context, index) {
            return PPHomeCardView(pp: pinpin).paddingOnly(bottom: 8);
          }),
    ));
  }
}
