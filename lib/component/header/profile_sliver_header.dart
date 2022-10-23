/// pinpin - home_sliver_header
/// Created by xhz on 2022/8/3
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/device/window_padding.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/home_sliver_header.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';

class PinPinPersonSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  const PinPinPersonSliverHeaderDelegate();

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
                child: Image.asset(
                  AppAssets.profile,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.88, 0.9),
              child: Opacity(
                opacity: diff,
                child: const PPCustomCapsuleButton(
                  background: AppTheme.secondary5,
                  child: Text(
                    '编辑',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF0076FC),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final arrow = PPImageButton(
      active: AppAssets.arrow_left_white,
      onPressed: PPNavigationBar.defaultBackAction,
      padding: 5,
    );

    final imgSize = diff * avatarSizeRange + avatarMinSize;
    final img = PPImageButton.fromImage(
      Image.network(
        'https://xhzq.xyz/images/doge.png',
        width: imgSize,
        height: imgSize,
        fit: BoxFit.scaleDown,
      ),
      onPressed: () {},
      padding: 1,
    );

    final username = SizedBox(
      height: avatarMinSize + 2,
      width: avatarMinSize * 2,
      child: Center(
        child: Text(
          "用户名",
          style:
              AppTheme.headline4.copyWith(color: diff >= 0.7 ? AppTheme.gray0 : AppTheme.gray100.withOpacity(1 - diff)),
        ),
      ),
    );

    // 1 -> 0.9
    final endLineY = 0.9 + 0.1 * diff;

    return Stack(
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
          // (-0.9,1) -> (-0.15, 0.1)
          alignment: Alignment(-0.15 - 0.75 * diff, endLineY),
          child: img,
        ),
        Align(
          // (-0.5,1) -> (0.1, 0.1)
          alignment: Alignment(0.1 - 0.6 * diff, endLineY),
          child: username,
        ),
      ],
    ).sized(height: height, width: width);
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
