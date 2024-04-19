/// pinpin - home_pp_card
/// Created by xhz on 06/08/2022

import 'package:flutter/material.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/constant.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:pinpin/model/user_info/user_info.dart';
import 'package:util/util.dart';
import 'package:widget/avatar.dart';
import 'package:widget/button/future_switch_button.dart';

class DemandingBubble extends StatelessWidget {
  const DemandingBubble({Key? key, required this.content}) : super(key: key);
  final String content;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          color: AppTheme.secondary3, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 9),
        child: Text(
          content,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white, height: 1.09),
          maxLines: 1,
        ),
      ),
    );
  }
}

class LabelBubble extends StatelessWidget {
  const LabelBubble({Key? key, this.content}) : super(key: key);
  final String? content;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const CapsuleClipper(),
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Color(0x80FFE3B3)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.9),
            child: Text(
              content ?? '未知',
              style: AppTheme.headline8.copyWith(color: AppTheme.primary2),
            ),
          ),
        ),
      ),
    );
  }
}

mixin PPHomeCardViewDelegate {
  //true说明更改成功
  Future<bool> pressedFollow(int pinpinId);
}

class PPHomeCardView extends StatelessWidget {
  const PPHomeCardView({
    Key? key,
    required this.pp,
    this.userInfo = UserInfo.sample,
    required this.delegate,
  }) : super(key: key);
  final PinPin pp;
  final UserInfo userInfo;
  final PPHomeCardViewDelegate delegate;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      pp.title,
      style: AppTheme.headline2,
      maxLines: 1,
    );

    final demandingQty = DemandingBubble(
      content: '${pp.nowNum}/${pp.demandingNum}',
    );

    final label = LabelBubble(content: AppAssets.labelMap[pp.type]![pp.label]?.title);

    final content = Text(
      pp.title,
      style: AppTheme.headline7,
      maxLines: 4,
      textAlign: TextAlign.start,
    );

    final timeline = Text(
      TimeConverter.timeDescriptionFromSeconds(pp.updatedAt),
      style: AppTheme.headline10.copyWith(color: AppTheme.gray80),
      maxLines: 1,
    );

    final avatar = Avatar(url: userInfo.image);

    final poster = Text(
      userInfo.username,
      style: AppTheme.headline11.copyWith(color: AppTheme.gray80),
      maxLines: 1,
    );

    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 10, left: 18, right: 15),
        decoration: const BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20)), boxShadow: [AppTheme.shadow]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                title,
                SizedBox(
                  height: 35,
                  width: 35,
                  child: FutureSwitchButton<bool>(
                    initValue: pp.isFollowed,
                    pressedSwitch: (now) async {
                      final res = await delegate.pressedFollow(pp.pinpinId);
                      return res ? !now : now;
                    },
                    builder: (now) {
                      return Image.asset(
                        now ? AppAssets.star_active : AppAssets.star,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 23,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  demandingQty,
                  const SizedBox(
                    width: 10,
                  ),
                  label
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            content,
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 24,
              child: Row(
                children: [
                  avatar,
                  const SizedBox(
                    width: 5,
                  ),
                  poster,
                  const SizedBox(
                    width: 20,
                  ),
                  ConstantWidget.onlineWidget,
                  const Spacer(),
                  timeline,
                  const SizedBox(
                    width: 2,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
