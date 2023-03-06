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
      this.actions = const [],
      this.leading,
      this.backAction = defaultBackAction,
      this.whiteAccent = false});

  final String? title;
  final Widget? leading;
  final List<Widget> actions;
  final void Function() backAction;
  final bool whiteAccent;

  static void defaultBackAction() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final Widget back;
    final padding = MediaQuery.of(context).viewPadding;
    if (null != leading) {
      back = leading!;
    } else if (ModalRoute.of(context)?.canPop == true) {
      back = PPImageButton(
        active: whiteAccent ? AppAssets.arrow_left_white : AppAssets.arrow_left,
        onPressed: backAction,
        // padding: 7.2,
      );
    } else {
      back = const SizedBox();
    }

    final TextStyle titleStyle;

    if (whiteAccent) {
      titleStyle = AppTheme.headline2.copyWith(color: Colors.white);
    } else {
      titleStyle = AppTheme.headline2;
    }
    return Padding(
      padding: EdgeInsets.only(right: padding.right, left: padding.left),
      child: SizedBox(
        height: PPNavigationBarHeight + padding.top,
        child: ColoredBox(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(top: padding.top),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: back,
                ),
                if (actions.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: IconTheme(
                        data: const IconThemeData(
                          color: AppTheme.primary,
                          size: 24,
                        ),
                        child: FittedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: actions,
                          ),
                        ),
                      ),
                    ),
                  ),
                FractionallySizedBox(
                  heightFactor: 0.64,
                  child: FittedBox(
                    child: Text(
                      title ?? "",
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(PPNavigationBarHeight);
}
