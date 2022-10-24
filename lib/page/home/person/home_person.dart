/// pinpin - view
/// Created by xhz on 07/08/2022

import 'package:flutter/material.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/bar_items/person_avatar.dart';
import 'package:pinpin/component/header/home_sliver_header.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/page/home/person/controller.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/component/header/sliver_header_delegate.dart';

extension _Bg on Widget {
  Widget _bg() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: this,
        ).background(const DecoratedBox(
          decoration: BoxDecoration(
            color: AppTheme.gray100,
            boxShadow: [AppTheme.shadow],
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        )),
      );
}

class PPHomePersonView extends StatelessWidget {
  const PPHomePersonView({Key? key}) : super(key: key);
  static final maxHeight = profileProtruding + backgroundMaxHeight;
  static final minHeight = PinPinHomeSliverHeaderDelegate.appBarMinHeight;
  static const profileProtruding = 56.0;
  static const profileHeight = 112.0;
  static const profileWidth = 345.0;
  static final backgroundMaxHeight = PinPinHomeSliverHeaderDelegate.backgroundMaxHeight;
  static const avatarSize = 56.0;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PPHomePersonController>();

    // right back icon
    final back = Image.asset(
      AppAssets.arrow_right,
      height: 45,
      fit: BoxFit.fitHeight,
    );

    Widget getItem(String title, void Function() function) {
      return HoldActiveButton(
        onPressed: function,
        builder: (_) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTheme.headline5,
              ),
              back
            ],
          ).paddingSymmetric(vertical: 3);
        },
      );
    }

    final headers = [
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverHeaderDelegate(
          //有最大和最小高度
          maxHeight: maxHeight,
          minHeight: minHeight,
          builder: _buildHeader,
        ),
      ),
    ];

    const div = Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: SizedBox(
        height: 1,
        width: double.infinity,
        child: ColoredBox(
          color: Color(0xFFF0F0F0),
        ),
      ),
    );

    return NestedScrollView(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          getItem("我的主页", controller.toProfilePage)._bg(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [getItem("我的收藏", controller.toXX), div, getItem("我发布的", controller.toXX)],
          )._bg(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [getItem("使用指南", controller.toXX), div, getItem("建议与反馈", controller.toXX)],
          )._bg(),
          getItem("退出登录", controller.logout)._bg(),
        ],
      ),
      headerSliverBuilder: (_, __) => headers,
    );
  }

  // 构建 header
  Widget _buildHeader(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final controller = Get.find<PPHomePersonController>();

    final height = max(minHeight, maxHeight - shrinkOffset);

    // 1 -> 0
    final diff = (height - minHeight) / (maxHeight - minHeight);

    final mailbox = PPImageButton(
      onPressed: controller.toXX,
      active: AppAssets.msg_white,
      size: 25,
      padding: 5,
    );

    // img
    final avatar = DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 1.6, strokeAlign: StrokeAlign.inside, color: AppTheme.primary),
        borderRadius: const BorderRadius.all(Radius.circular(28)),
      ),
      child: PersonAvatar(
        url: controller.userInfo.value.image,
        size: avatarSize,
      ),
    );

    final radius = Radius.circular(diff * 20 + 20);

    final background = SizedBox(
      height: min(height, backgroundMaxHeight),
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: radius, bottomRight: radius),
          color: Colors.blueAccent,
        ),
      ),
    );

    final profileH = diff * (profileHeight - profileProtruding) + profileProtruding;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          background,
          Align(
            alignment: const Alignment(0, 1),
            child: SizedBox(
              width: profileWidth,
              height: avatarSize / 2 + profileH,
              child: Obx(
                () => Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: profileWidth,
                        height: profileH,
                        child: Opacity(
                          opacity: max(diff * 1.7 - 0.7, 0),
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [AppTheme.shadow],
                            ),
                            child: FractionallySizedBox(
                              widthFactor: 0.85,
                              heightFactor: 0.5,
                              child: Align(
                                alignment: const Alignment(-0.9, 0.9),
                                child: Text(
                                  controller.userInfo.value.brief,
                                  style: AppTheme.headline8,
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Opacity(
                        opacity: diff,
                        child: FittedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              avatar,
                              Text(
                                controller.userInfo.value.username,
                                style: AppTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.86, 0.5 - 1 * diff), //(-.42)->(0.5),
            child: mailbox,
          ),
        ],
      ),
    );
  }
}
