import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/key_board/key_board_detector.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
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
          appBar: const PPNavigationBar(
              title: "昵称",
              background: Color(0xFF0076FC),
              whiteAccent: true,
            ),
            body: SafeArea(
          child: InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).viewPadding.top),
                            const Padding(padding: EdgeInsets.only(bottom: 20)),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: PPTextField(
                                    controller:
                                        controller.textEditingController,
                                    hintText: "请输入用户名",
                                  )).marginSymmetric(horizontal: 16),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: PPCommonTextButton(
                          title: '确认发布',
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
            ),
          ),
        )));
  }
}
