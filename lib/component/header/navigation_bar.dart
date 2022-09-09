/// pinpin - navigation_bar
/// Created by xhz on 06/09/2022

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';

class PPNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const PPNavigationBar({super.key, this.title, this.trailing = const SizedBox(), this.backAction = defaultBackAction});

  final String? title;
  final Widget trailing;
  final void Function() backAction;

  static void defaultBackAction() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final Widget back;
    if (Get.previousRoute != "") {
      back = PPImageButton.fromImage(
        const Icon(
          Icons.arrow_back_ios_new,
          color: AppTheme.primary,
          size: 24,
        ),
        onPressed: backAction,
        padding: 7.2,
      );
    } else {
      back = const SizedBox();
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: SizedBox.expand(
              child: back,
            )),
            Expanded(
                flex: 7,
                child: Text(
                  title ?? "",
                  textAlign: TextAlign.center,
                  style: AppTheme.headline2,
                )),
            Expanded(
              child: SizedBox.expand(
                child: IconTheme(
                    data: const IconThemeData(
                      color: AppTheme.primary,
                      size: 24,
                    ),
                    child: trailing),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 40);
}
