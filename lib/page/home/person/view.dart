/// pinpin - view
/// Created by xhz on 07/08/2022

import 'package:flutter/material.dart';
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
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverHeaderDelegate(
                //有最大和最小高度
                maxHeight: 170,
                minHeight: 170,
                child: buildHeader(),
              ),
            )
          ];
        },
        body: Scrollbar(
          // 显示进度条
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                //动态创建一个List<Widget>
                children: str
                    .split("")
                    //每一个字母都用一个Text显示,字体为原来的两倍
                    .map((c) => Text(
                          c,
                          textScaleFactor: 2.0,
                        ))
                    .toList(),
              ),
            ),
          ),
        ));
  }

  double _computeRadius(double height) {
    return 0.3703703704 * (height - 170) + 40;
  } //

  // 构建 header
  Widget buildHeader() {

    final content = Text(
      "啊对对对对",
      style: Get.textTheme.headline5,
    );

    final username = Text(
      "用户名",
      style: Get.textTheme.headline5,
    );

    final mailbox = Image.asset(
      AppAssets.msg_white,
      height: 27,
      fit: BoxFit.fitHeight,
    ).paddingAll(7);

    final profile = Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      constraints: const BoxConstraints.tightFor(width: 354, height: 122),
      alignment: const Alignment(0, 0.7),
      child: content,
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
              alignment: const Alignment(0, 3),
              child: username,
            ),

            Align(
              alignment: const Alignment(0.82, -0.55),
              child: mailbox,
            ),
          ],
        ).sized(height: height, width: width);
      },
    );
  }
}
