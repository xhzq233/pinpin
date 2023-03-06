import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';
import 'package:util/util.dart';

import 'controller.dart';

class EditLabelsPage extends StatelessWidget {

  EditLabelsPage({Key? key}) : super(key: key);

  final controller = Get.find<EditLabelsController>();

  @override
  Widget build(BuildContext context) {

    final add = PPImageButton(
      onPressed: () {},
      active: AppAssets.msg_white,
      size: 25,
      padding: 5,
    );

    final addLabel = ClipPath(
      clipper: const CapsuleClipper(),
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
          child: FittedBox(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Icon(Icons.add),
                Text(
                  "自定义标签",
                  style: AppTheme.headline6,
                )
              ],
            ),
          ),
        ),
      ),
    );
    const myLabels = ['白羊座', '二次元', 'intp', '巴拉拉', 'lgbt', 'lgbtq', '巴拉拉'];

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const PPNavigationBar(title: "标签页"),
          const Padding(padding: EdgeInsets.only(bottom: 20)),

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [Text("添加标签", style: AppTheme.headline5,)],
          ).marginSymmetric(horizontal: 16),

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [Text("已添加5个，还可以再添加10个", style: AppTheme.headline7,)],
          ).marginSymmetric(horizontal: 16),
          const Padding(padding: EdgeInsets.only(bottom: 13)),
          DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                    spacing: 10, // 主轴(水平)方向间距
                    alignment: WrapAlignment.start, //沿主轴方向居中
                    children: myLabels
                        .map((e) => SizedBox(
                      height: 21,
                      child: PPCustomCapsuleButton(
                        onPressed: (){}, // 点击变色
                        background: AppTheme.secondary5,
                        child: Text(
                          e,
                          style: AppTheme.headline9.copyWith(color: AppTheme.primary),
                        ),
                      ),
                    ))
                        .toList()),
              ),
            ),
          ).marginSymmetric(horizontal: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [SizedBox(height: 20,child: addLabel,),],
          ).marginSymmetric(horizontal: 16),

          const Padding(padding: EdgeInsets.only(bottom: 300)),
          PPCommonTextButton(
            title: '提交',
            onPressed: () {
              Get.back();
            },
          )
        ],
      )
    );
  }
}
