import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/key_board/key_board_detector.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:util/util.dart';
import 'controller.dart';

class EditUsernamePage extends StatelessWidget {
  EditUsernamePage({Key? key}) : super(key: key);

  final controller = Get.find<EditUsernameController>();

  @override
  Widget build(BuildContext context) {
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
                          const PPNavigationBar(title: "昵称"),
                          const Padding(padding: EdgeInsets.only(bottom: 20)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: TextField(
                                controller: controller.controller,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  var filterPattern = RegExp(
                                      r'(?![a-zA-Z.]+$)(?![0-9A-Z.]+$)(?![0-9a-z.]+$)(?![0-9a-zA-Z]+$)[0-9a-zA-Z.]{6,8}');
                                  final Iterable<Match> matches =
                                  filterPattern.allMatches(value);
                                  if (matches.isNotEmpty) {}
                                },
                              ),
                            )
                                .background(const DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppTheme.gray100,
                                boxShadow: [AppTheme.shadow],
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ))
                                .marginSymmetric(horizontal: 16),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, 2.0),
                      child: Obx(
                            () => Visibility(
                          visible: !controller.isKeyboardShowing.value,
                          child: PPCommonTextButton(
                            title: '确认发布',
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
