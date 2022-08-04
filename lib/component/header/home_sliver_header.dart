/// pinpin - home_sliver_header
/// Created by xhz on 2022/8/3
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/component/search_bar/search_bar.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import '../stateful_button/stateful_button.dart';
import '/app/i18n/i18n_names.dart';

class PinPinHomeSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  const PinPinHomeSliverHeaderDelegate();

  static const backgroundMaxHeight = 152.0;
  static const appBarMaxHeight = backgroundMaxHeight + searchBarProtruding;
  static const appBarMinHeight = 98.0;
  static const appBarHeightRange = appBarMaxHeight - appBarMinHeight;
  static const searchBarProtruding = 11.0;
  static const searchBarMaxWidth = 332.0;
  static const searchBarMinWidth = 286.0;
  static const searchBarWidthRange = searchBarMaxWidth - searchBarMinWidth;
  static const searchBarMaxHeight = 50.0;
  static const searchBarMinHeight = 34.0;
  static const searchBarHeightRange = searchBarMaxHeight - searchBarMinHeight;

  //(152 - 98) -> (40 - 20)
  double _computeRadius(double height) {
    return 0.3703703704 * (height - backgroundMaxHeight) + 40;
  }

  // height from appBarMaxHeight to appBarMinHeight
  double _computeOpacity(double height) {
    return max(0.0, 1.0 - (appBarMaxHeight - height) / 50);
  }

  // Alignment(0, 1) -> Alignment(-0.33, 0.66)
  Alignment _computeSearchBarAlignment(double height) {
    final diff = (height - appBarMaxHeight) / appBarHeightRange * 0.4;
    return Alignment(diff, 1.0 + diff);
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final title = Text(
      I18n.title.tr,
      style: Get.textTheme.headline5,
    );

    final mailbox = Image.asset(
      AppAssets.msg_white,
      height: 27,
      fit: BoxFit.fitHeight,
    ).paddingAll(7);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

        final radius = Radius.circular(_computeRadius(height));
        final background = DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: radius, bottomRight: radius), color: Colors.blueAccent),
        ).sized(height: min(height, backgroundMaxHeight), width: width);

        final diff = Curves.easeInOutSine.transform((height - appBarMinHeight) / appBarHeightRange);
        // 1 -> 0
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            background,
            Align(
              alignment: const Alignment(-0.8, 0),
              child: Opacity(
                opacity: _computeOpacity(height),
                child: title,
              ),
            ),
            Align(
              alignment: Alignment((1.0 - diff) * 0.04 + 0.86, 0.66 * (1.0 - diff)),
              //0.8->0.92,  0->0.6
              child: mailbox,
            ),
            Align(
              alignment: _computeSearchBarAlignment(height),
              child: const PPHomeSearchBar().sized(
                  width: diff * searchBarWidthRange + searchBarMinWidth,
                  height: diff * searchBarHeightRange + searchBarMinHeight),
            ),
          ],
        ).sized(height: height, width: width);
      },
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
