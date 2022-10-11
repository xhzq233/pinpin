/// pinpin - view
/// Created by xhz on 07/08/2022

import 'package:flutter/material.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/page/home/person/controller.dart';
import 'package:get/get.dart';

import '../../../app/assets/name.dart';
import '../../../component/header/header.dart';
import '../../../component/header/home_sliver_header.dart';
import '../../../component/header/person_sliver_header.dart';
import '../../../component/header/sliver_header_delegate.dart';

class PPHomePersonView extends GetView<PPHomePersonController> {
  const PPHomePersonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> items = ["我的主页", "我的收藏", "我发布的", "使用指南", "建议与反馈", "退出登录"];

    // right back icon
    final back = Image.asset(
      AppAssets.arrow_right,
      height: 45,
      fit: BoxFit.fitHeight,
    );

    Widget getItem(String title, void Function() function, bool hasBottom) {
      return Container(
          decoration: BoxDecoration(
              color: Color(0xffffff),
              borderRadius: hasBottom
                  ? null
                  : const BorderRadius.all(Radius.circular(20.0)),
              border: !hasBottom
                  ? null
                  : const Border(
                      bottom: BorderSide(color: Colors.black12, width: 0.5),
                    )),
          constraints: const BoxConstraints.tightFor(width: 354, height: 50),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 21,
                child: Text(title),
              ).marginOnly(top: 10, bottom: 10),
              Expanded(flex: 1, child: Container()),
              back
            ],
          )).onTap(function);
    }

    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverHeaderDelegate(
            //有最大和最小高度
            maxHeight: 170,
            minHeight: 170,
            child: buildHeader(),
          ),
        ),

        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Column(children: [
                    const SizedBox(
                      height: 40,
                    ),
                    getItem("我的主页", () {Get.toNamed(RN.profile);}, false).marginOnly(bottom: 18),
                    getItem("我的收藏", () {}, true),
                    getItem("我发布的", () {}, false).marginOnly(bottom: 18),
                    getItem("使用指南", () {}, true),
                    getItem("建议与反馈", () {}, false).marginOnly(bottom: 40),
                    getItem("退出登录", () {}, false).marginOnly(bottom: 20),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _computeRadius(double height) {
    return 0.3703703704 * (height - 170) + 40;
  }

  // 构建 header
  Widget buildHeader() {
    // signature content
    const content = Text(
      "啊对对对对",
      style: AppTheme.headline8,
      textAlign: TextAlign.left,
    );

    // username
    final username = Text(
      "用户名",
      style: Get.textTheme.headline6,
    );

    final mailbox = Image.asset(
      AppAssets.msg_white,
      height: 27,
      fit: BoxFit.fitHeight,
    ).paddingAll(7);

    // img
    final img = Container(
      height: 58,
      width: 58,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: const DecorationImage(
              image: AssetImage(AppAssets.person), fit: BoxFit.cover),
          border: Border.all(
            color: Colors.blueAccent,
            width: 2,
          )),
    );

    // profile box
    final profile = Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      constraints: const BoxConstraints.tightFor(width: 354, height: 122),
      alignment: const Alignment(0, 0.7),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [content],
      )
          .marginSymmetric(horizontal: 24, vertical: 10)
          .paddingSymmetric(horizontal: 10, vertical: 2),
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

        final radius = Radius.circular(_computeRadius(height));

        final background = DecoratedBox(
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.only(bottomLeft: radius, bottomRight: radius),
              color: Colors.blueAccent),
        ).sized(height: height, width: width);

        return Stack(
          alignment: Alignment.topCenter,
          children: [
            background,
            Align(
              alignment: const Alignment(0, 3),
              child: profile,
            ),
            Align(
              alignment: const Alignment(0, 0.8),
              child: username,
            ),
            Align(
              alignment: const Alignment(0.82, -0.55),
              child: mailbox,
            ),
            Align(
              alignment: const Alignment(0, 0.2),
              child: img,
            ),
          ],
        ).sized(height: height, width: width);
      },
    );
  }
}
