/// pinpin - home_sliver_header
/// Created by xhz on 2022/8/3
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/component/search_bar/search_bar.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import '../../app/theme/app_theme.dart';
import '../../util/clipper.dart';
import '/app/i18n/i18n_names.dart';

class PinPinPersonSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  const PinPinPersonSliverHeaderDelegate();

  static const backgroundMaxHeight = 176.0;
  static const backgroundMinHeight = 140.0;
  static const appBarMaxHeight = 444.0;
  static const appBarMinHeight = 140.0;
  static const appBarHeightRange = appBarMaxHeight - appBarMinHeight;

  static const circleImgMaxWidth = 80.0;
  static const circleImgMinWidth = 58.0;
  static const circleImgWidthRange = circleImgMaxWidth - circleImgMinWidth;


  Alignment _computeCircleImgAlignment(double height) {
    final diff = (height - appBarMaxHeight) / appBarHeightRange;
    return Alignment(-0.85 * (1.0 + diff), 1.6 * (diff + 1.0) - 0.4 * diff);
  }

  Alignment _computeUsernameAlignment(double height) {
    final diff = (height - appBarMaxHeight) / appBarHeightRange;
    return Alignment(-0.5 * (1.0 + diff), 1.55 * (diff + 1.0) + 0.2 * diff);
  }

  double _computeCircleImgSize(double height) {
    final diff = (height - appBarMaxHeight) / appBarHeightRange;
    return circleImgMinWidth  + circleImgWidthRange * (-diff);
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    /// background
    final background = ConstrainedBox(
      constraints: const BoxConstraints.expand(), // 自适应屏幕
      child: Image.asset(
        AppAssets.profile,
        fit: BoxFit.cover,
      ),
    );

    final arrow = Image.asset(
      AppAssets.arrow_left_white,
      height: 25,
      fit: BoxFit.fitHeight,
    ).onTap(() {
      Get.back();
    });

    const edit = ClipPath(
      clipper: CapsuleClipper(),
      child: DecoratedBox(
          decoration: BoxDecoration(color: Color(0xFFE6EDFF)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Text(
              '编辑',
              style: TextStyle(fontSize: 14, color: Color(0xFF0076FC)),
            ),
          )),
    );

    Widget getImg(double radius) {
      return Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: const DecorationImage(
                image: AssetImage(AppAssets.profile), fit: BoxFit.cover),
            border: Border.all(
              color: Colors.white,
              width: 2,
            )),
      );
    }

    final username = Text(
      "用户名",
      style: Get.textTheme.headline6,
    );


    // print(shrinkOffset);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

        final diff = Curves.easeInOutSine.transform((height - appBarMinHeight) / appBarHeightRange);
        print(height);

        return Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    background.sized(height: 140),
                    const Align(
                      alignment: Alignment(0.85, 0.9),
                      child: edit,
                    ),
                    Align(
                      alignment: const Alignment(-0.85, -0.5),
                      child: arrow,
                    ),
                    Align(
                      alignment: _computeCircleImgAlignment(height),
                      child: getImg(_computeCircleImgSize(height)),
                    ),
                    Align(
                      alignment: _computeUsernameAlignment(height),
                      child: username,
                    ),
                  ],
                ).sized(height: 140),
              ],
            )
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
