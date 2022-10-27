/// pinpin - home_sliver_header
/// Created by xhz on 2022/8/3
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/device/window_padding.dart';
import 'package:pinpin/component/search_bar/search_bar.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';
import '/app/i18n/i18n_names.dart';

class PinPinHomeSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  const PinPinHomeSliverHeaderDelegate();

  static final backgroundMaxHeight = appBarMinHeight + 53;
  static final appBarMaxHeight = backgroundMaxHeight + searchBarProtruding;
  static final appBarMinHeight = PPNavigationBarHeight + windowPadding.top; //59+40
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
      I18n.title.tr,
      style: Get.textTheme.headline5,
    );

    const imagePadding = 8.0;
    final mailbox = PPImageButton(
      onPressed: () {},
      active: AppAssets.msg_white,
      size: searchBarMinHeight - imagePadding,
      padding: imagePadding / 2, //to make img centralized
    );

    const width = double.infinity;

    final radius = Radius.circular(20.0 + diff * 20);
    final background = DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: radius, bottomRight: radius), color: Colors.blueAccent),
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
            alignment: const Alignment(-0.8, -1),
            child: Padding(
              padding: EdgeInsets.only(top: windowPadding.top + diff * 12),
              child: Opacity(
                opacity: max(diff * 1.5 - 0.5, 0),
                child: title,
              ),
            ),
          ),
          Align(
            alignment: Alignment((1.0 - diff) * 0.05 + 0.86, 0.66 - 1.66 * curved),
            //(0.86, -1)->(0.91, 0.66),
            child: Padding(
              padding: EdgeInsets.only(top: windowPadding.top * Curves.decelerate.transform(diff) + diff * 12),
              child: mailbox,
            ),
          ),
          Align(
            //Alignment(0, 1) -> Alignment(-0.33, 0.66)
            alignment: Alignment((1.0 - diff) * (-0.33), 0.66 + 0.33 * diff),
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
