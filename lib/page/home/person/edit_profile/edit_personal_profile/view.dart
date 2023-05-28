import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/key_board/key_board_detector.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
import 'package:util/util.dart';

import 'controller.dart';

class EditPersonalProfilePage extends StatelessWidget {
  EditPersonalProfilePage({Key? key}) : super(key: key);

  final controller = Get.find<EditPersonalProfileController>();

  @override
  Widget build(BuildContext context) {
    final profile = PPTextField(
      textFieldStyle: PPTextFieldStyle.backgroundFilled,
      maxLines: 5,
      maxLength: 100,
      hintText: '提示：可以写兴趣爱好、星座、mbti等等',
      controller: controller.textEditingController,
      counterBuilder: null,
    );

    return KeyboardDetector(
        keyboardShowCallback: (show) {
          controller.isKeyboardShowing(show);
        },
        content: Scaffold(
            appBar: const PPNavigationBar(
              title: "个人简介",
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
                                profile.sized(width: 354, height: 191),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Obx(
                              () => Visibility(
                                visible: !controller.isKeyboardShowing.value,
                                child: PPCommonTextButton(
                                  title: '确认修改',
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ),
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
