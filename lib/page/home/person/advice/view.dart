import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/key_board/key_board_detector.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:util/util.dart';

import 'controller.dart';

class AdvicePage extends StatelessWidget {
  const AdvicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdviceController>();

    final profile = DecoratedBox(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [AppTheme.shadow]),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        heightFactor: 0.8,
        child: TextField(
          style: AppTheme.headline7,
          textAlign: TextAlign.left,
          maxLines: 5,
          controller: controller.etController,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );

    return KeyboardDetector(
        keyboardShowCallback: (show) {
          controller.isKeyboardShowing(show);
        },
        content: Scaffold(
            body: InkWell(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                highlightColor: Colors.transparent, // 去除水波纹
                splashColor: Colors.transparent,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          const PPNavigationBar(title: "建议与反馈"),
                          const Padding(padding: EdgeInsets.only(bottom: 20)),
                          profile.sized(width: 354, height: 191),
                        ],
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, 2.0),
                      child: Obx(
                        () => Visibility(
                          visible: !controller.isKeyboardShowing.value,
                          child: PPCommonTextButton(
                            title: '提交',
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
