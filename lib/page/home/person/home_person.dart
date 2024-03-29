/// pinpin - view
/// Created by xhz on 07/08/2022

import 'package:flutter/material.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';
import 'package:pinpin/manager/account_manager/account_manager.dart';
import 'package:util/util.dart';
import 'package:pinpin/page/home/main/home_sliver_header.dart';
import 'package:pinpin/page/home/person/controller.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/component/header/sliver_header_delegate.dart';
import 'package:widget/avatar.dart';

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
    final account = Get.find<AccountManager>().current;

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
    final List<Widget> children = [];

    if (null != account) {
      children.addAll([
        getItem("我的主页", controller.toProfilePage)._bg(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [getItem("我的收藏", controller.toCollectionsPage), div, getItem("我发布的", controller.toReleasesPage)],
        )._bg(),
      ]);
    }
    children.addAll([
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [getItem("使用指南", controller.toGuidancePage), div, getItem("建议与反馈", controller.toAdvicePage)],
      )._bg(),
    ]);
    if (null != account) {
      children.addAll([
        getItem("退出登录", () => controller.logOut())._bg(),
      ]);
    }

    return NestedScrollView(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 16),
        children: children,
      ).paddingSymmetric(
        horizontal: 16,
      ),
      headerSliverBuilder: (_, __) => headers,
    );
  }

  // 构建 header
  Widget _buildHeader(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final account = Get.find<AccountManager>().current;

    final controller = Get.find<PPHomePersonController>();

    final height = max(minHeight, maxHeight - shrinkOffset);

    // 1 -> 0
    final diff = (height - minHeight) / (maxHeight - minHeight);

    // signature content
    final personSignature = Text(
      account?.userInfo.username ?? '暂无个人简介。',
      style: AppTheme.headline8,
      textAlign: TextAlign.left,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );

    // username
    final username = Text(
      account?.userInfo.username ?? '未登录',
      style: AppTheme.headline6,
    );

    final mailbox = PPImageButton(
      onPressed: () {
        Get.toNamed(RN.message_center);
      },
      active: AppAssets.msg_white,
      size: 25,
      padding: 3,
    );

    // img
    Widget avatar = ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 64, maxWidth: 64),
      child: DecoratedBox(
        decoration: BoxDecoration(border: Border.all(width: 2, color: AppTheme.primary), shape: BoxShape.circle),
        child: Avatar(
          url: account?.userInfo.image,
          margin: 2,
          onPressed: controller.pressEditAvatar,
        ),
      ),
    );

    // profile box
    final profile = Opacity(
      opacity: max(diff * 1.7 - 0.7, 0),
      child: DecoratedBox(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.white, boxShadow: [AppTheme.shadow]),
        child: FractionallySizedBox(
          widthFactor: 0.85,
          heightFactor: 0.5,
          child: Align(
            alignment: const Alignment(-0.9, 0.9),
            child: personSignature,
          ),
        ),
      ),
    );

    final radius = Radius.circular(diff * 20 + 20);

    final background = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: radius, bottomRight: radius),
        color: AppTheme.primary,
      ),
    ).sized(height: min(height, backgroundMaxHeight), width: double.infinity);

    final Widget title = Opacity(
      opacity: diff,
      child: FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            avatar,
            username,
          ],
        ),
      ),
    );

    final profileH = diff * (profileHeight - profileProtruding) + profileProtruding;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        background,
        Align(
          alignment: const Alignment(0, 1),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: profile.sized(width: profileWidth, height: profileH),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: title,
              )
            ],
          ).sized(width: profileWidth, height: avatarSize / 2 + profileH),
        ),
        Align(
          alignment: Alignment(0.8, 0.39 - 1 * diff), //(-.42)->(0.5),
          child: mailbox,
        ),
      ],
    ).sized(height: height, width: double.infinity);
  }
}
