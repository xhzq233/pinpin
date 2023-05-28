/// pinpin - home_sliver_header
/// Created by xhz on 2022/8/3
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/device/window_padding.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/search_bar/search_bar.dart';
import 'package:util/util.dart';
import 'package:get/get.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';

class PinPinHomeSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  const PinPinHomeSliverHeaderDelegate();

  static final backgroundMaxHeight = appBarMinHeight + 64;
  static final appBarMaxHeight = backgroundMaxHeight + searchBarProtruding;
  static final appBarMinHeight = NavigationBarHeight + windowPadding.top;
  static final appBarHeightRange = appBarMaxHeight - appBarMinHeight;

  static const searchBarProtruding = 11.0;
  static const searchBarMaxWidth = 332.0;
  static const searchBarMinWidth = 286.0;
  static const searchBarWidthRange = searchBarMaxWidth - searchBarMinWidth;
  static const searchBarMaxHeight = 50.0;
  static const searchBarMinHeight = 34.0;
  static const searchBarHeightRange = searchBarMaxHeight - searchBarMinHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final height = max(appBarMinHeight, appBarMaxHeight - shrinkOffset);
    // 1 -> 0
    final diff = (height - appBarMinHeight) / appBarHeightRange;
    final title = Text(
      '1037拼拼',
      style: AppTheme.headline1.copyWith(color: Colors.white),
    );

    const imagePadding = 8.0;
    final mailbox = PPImageButton(
      onPressed: () {
        Get.toNamed(RN.message_center);
      },
      active: AppAssets.msg_white,
      size: searchBarMinHeight - imagePadding,
      padding: imagePadding / 2, //to make img centralized
    );

    const width = double.infinity;

    final radius = Radius.circular(20.0 + diff * 20);
    final background = DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: radius, bottomRight: radius), color: AppTheme.primary),
    ).sized(height: min(height, backgroundMaxHeight), width: width);

    final curved = Curves.easeOutCubic.transform(diff); // slower when near the ending

    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          background,
          Align(
            alignment: const Alignment(-0.76, -0.8),
            child: Padding(
              padding: EdgeInsets.only(top: windowPadding.top + diff * 12),
              child: Opacity(
                opacity: max(diff * 1.5 - 0.5, 0),
                child: title,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.82, 0.66 - (0.8 + 0.66) * curved),
            //(0.82, -0.8)->(, 0.66),
            child: Padding(
              padding: EdgeInsets.only(top: windowPadding.top * Curves.decelerate.transform(diff) + diff * 12),
              child: mailbox,
            ),
          ),
          Align(
            //Alignment(0, 1) -> Alignment(-0.5, 0.66)
            alignment: Alignment((1.0 - diff) * (-0.5), 0.66 + 0.33 * diff),
            child: const Hero(tag: PPHomeSearchBar.heroTag, child: PPHomeSearchBar()).sized(
                width: diff * searchBarWidthRange + searchBarMinWidth,
                height: diff * searchBarHeightRange + searchBarMinHeight),
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
