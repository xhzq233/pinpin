/// pinpin - home_sliver_header
/// Created by xhz on 2022/8/3
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/device/window_padding.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/page/home/main/home_sliver_header.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/model/user_info/user_info.dart';
import 'package:util/util.dart';
import 'package:widget/avatar.dart';
import 'package:widget/button/hold.dart';

class PinPinPersonSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  const PinPinPersonSliverHeaderDelegate(this.userInfo);

  final UserInfo userInfo;

  static final backgroundMaxHeight = backgroundMinHeight + 77;
  static final backgroundMinHeight = PinPinHomeSliverHeaderDelegate.appBarMinHeight;
  static final appBarMaxHeight = backgroundMaxHeight + avatarMaxSize / 2;
  static final appBarMinHeight = backgroundMinHeight;
  static final appBarHeightRange = appBarMaxHeight - appBarMinHeight;

  static const avatarMaxSize = 66.6;
  static const avatarMinSize = 32.0;
  static const avatarSizeRange = avatarMaxSize - avatarMinSize;

  // build in every frame
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final height = max(appBarMinHeight, appBarMaxHeight - shrinkOffset);
    const width = double.infinity;

    // 1 -> 0
    final diff = (height - appBarMinHeight) / appBarHeightRange;

    /// background
    final background = SizedBox(
      height: height - (avatarMaxSize / 2) * diff,
      width: width,
      child: ClipRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            const ColoredBox(color: AppTheme.primary),
            Opacity(
              opacity: diff,
              child: Transform.scale(
                scale: max(0.8 + diff * 0.32, 1), //1.12 -> 1 -> 1,
                child: Image.network(
                  userInfo.background,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/profile.png', //出错加载默认头像
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.88, 0.9),
              child: Opacity(
                opacity: diff,
                child: PPCustomCapsuleButton(
                  background: AppTheme.secondary5,
                  onPressed: () => Get.toNamed(RN.edit_bg),
                  child: Text(
                    '编辑',
                    style: AppTheme.headline6.copyWith(color: AppTheme.primary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final arrow = Padding(
      padding: const EdgeInsets.only(left: 15,top: 5),
      child: HoldButton(
        onPressed: PPNavigationBar.defaultBackAction,
        child: Image.asset(
          AppAssets.arrow_left_white,
          width: 24,
          height: 24,
        ),
      ),
    );

    final imgSize = diff * avatarSizeRange + avatarMinSize;
    final avatar = Avatar(
      url: userInfo.image,
      margin: 5 * diff,
    ).sized(width: imgSize, height: imgSize);

    final username = SizedBox(
      height: avatarMinSize + 2,
      width: avatarMinSize * (2 + diff),
      child: Center(
        child: FittedBox(
          child: Text(
            userInfo.username,
            style: AppTheme.headline4.copyWith(
              color: diff >= 0.7 ? AppTheme.gray0 : AppTheme.gray100.withOpacity(1 - diff),
            ),
          ),
        ),
      ),
    );

    // 1 -> 0.9
    final endLineY = 0.9 + 0.1 * diff;

    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          background,
          Align(
            alignment: const Alignment(-1, -1),
            child: Padding(
              padding: EdgeInsets.only(top: windowPadding.top, left: 3),
              child: arrow,
            ),
          ),
          Align(
            // (-0.9,1) -> (-0.18, 0.1)
            alignment: Alignment(-0.18 - 0.72 * diff, endLineY),
            child: avatar,
          ),
          Align(
            // (-0.5,1) -> (0.13, 0.1)
            alignment: Alignment(0.13 - 0.63 * diff, endLineY),
            child: username,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => appBarMaxHeight;

  @override
  double get minExtent => appBarMinHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
