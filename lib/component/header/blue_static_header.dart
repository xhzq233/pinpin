/// pinpin - navigation_bar
/// Created by xhz on 06/09/2022

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/device/window_padding.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';

class PPNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const PPNavigationBar(
      {super.key,
      this.title,
      this.trailing = const SizedBox(),
      this.backAction = defaultBackAction,
      this.isChat = false,
      this.onMenuItemSelected = defaultMenuAction});

  final String? title;
  final Widget trailing;
  final bool isChat;
  final void Function() backAction;
  final void Function() onMenuItemSelected;

  static void defaultBackAction() {
    Get.back();
  }

  static void defaultMenuAction() {}

  @override
  Widget build(BuildContext context) {
    final Widget back;
    final padding = windowPadding;
    if (Get.previousRoute != "") {
      back = PPImageButton(
        active: AppAssets.arrow_left,
        onPressed: backAction,
        padding: 7.2,
      );
    } else {
      back = const SizedBox();
    }

    final menu = PPImageButton(
      active: AppAssets.more,
      onPressed: onMenuItemSelected,
      padding: 7.2,
    );

    final trailingWrapper = Padding(
        padding: const EdgeInsets.all(7.2),
        child: IconTheme(
          data: const IconThemeData(
            color: AppTheme.primary,
            size: 24,
          ),
          child: trailing,
        ),
    );

    return Padding(
      padding: EdgeInsets.only(
          top: padding.top, right: padding.right, left: padding.left),
      child: SizedBox(
        height: PPNavigationBarHeight,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(-0.9, 0),
              child: back,
            ),
            Align(
              alignment: Alignment(0.9, 0),
              child: isChat ? menu : trailingWrapper
            ),
            Center(
              child: Text(
                title ?? "",
                textAlign: TextAlign.center,
                style: AppTheme.headline2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(PPNavigationBarHeight);
}
