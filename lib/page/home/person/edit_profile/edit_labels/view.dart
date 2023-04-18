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
    const myLabels = [
      '白羊座',
      '二次元',
      'intp',
      '巴拉拉',
      'lgbt',
      'lgbtq',
      '巴拉拉',
      '白羊座',
      '二次元',
      'intp',
      '巴拉拉',
      'lgbt',
      'lgbtq',
      '巴拉拉',
      '白羊座',
      '二次元',
      'intp',
      '巴拉拉',
      'lgbt',
      'lgbtq',
      '巴拉拉',
      '白羊座',
      '二次元',
      'intp',
      '巴拉拉',
      'lgbt',
      'lgbtq',
      '巴拉拉'
    ];

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const PPNavigationBar(title: "标签页"),
                      SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "添加标签",
                            style: AppTheme.headline5,
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "已添加5个，还可以再添加10个",
                            style: AppTheme.headline7,
                          )
                        ],
                      ),
                      SizedBox(height: 13),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              alignment: WrapAlignment.start,
                              children: myLabels
                                  .map((e) => PPCustomCapsuleButton(
                                        onPressed: () {}, // 点击变色
                                        background: AppTheme.secondary5,
                                        child: Text(
                                          e,
                                          style: AppTheme.headline9.copyWith(
                                              color: AppTheme.primary),
                                        ),
                                      ))
                                  .toList()),
                        ),
                      ),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                            child: addLabel,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: PPCommonTextButton(
                  title: '提交',
                  onPressed: () {
                    Get.back();
                  },
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 115)
      ],
    ));
  }
}
