import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/page/home/person/profile_sliver_header.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/page/unknown_page/view.dart';
import 'package:util/util.dart';

import 'controller.dart';

class ProfilePage extends StatelessWidget with PPHomeCardViewDelegate {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 页面布局逻辑
    final logic = Get.find<ProfileController>();
    final userInfo = logic.userInfo;

    if (null == userInfo) {
      return const UnknownRoutePage();
    }
    final historyOpen = userInfo.history != null;

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

    final brief = Text(
      userInfo.brief.isEmpty ? '这个人好懒...' : userInfo.brief,
      style: AppTheme.headline9,
      maxLines: null,
      textAlign: TextAlign.left,
    );

    const launchers = Text(
      "我发布的",
      style: AppTheme.headline4,
      textAlign: TextAlign.left,
    );

    const bg = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
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

    final myLabels = userInfo.myTags.trim().isEmpty ? ['Nothing here'] : userInfo.myTags.trim().split(',');
    final body = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: PinPinPersonSliverHeaderDelegate(userInfo),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                personDesc,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: DecoratedBox(
                    decoration: bg,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: brief,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: labels,
                ),
                DecoratedBox(
                  decoration: bg,
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
        if (historyOpen)
          SliverFillRemaining(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: userInfo.history!.length,
              //prototype
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: PPHomeCardView(pp: userInfo.history![index],delegate: this,),
                );
              },
            ),
          ),
      ],
    );

    return ColoredBox(
      color: AppTheme.lightBackground,
      child: body,
    );
  }


  // delegates
  @override
  Future<bool> pressedFollow(int pinpinId) async {
    final res = await Get.find<PPNetWorkInterface>().followPinPin(pinPinId: pinpinId);

    if (null == res) return false;

    toast(res.msg);
    Logger.i(res.msg);
    return true;
  }
}
