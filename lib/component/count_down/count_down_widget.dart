/// pinpin - count_down_widget
/// Created by xhz on 12/09/2022

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/loading/loading.dart';
import 'package:widget/button/hold.dart';

class CountDownController extends GetxController {
  CountDownController({int maxSeconds = 60})
      : max = maxSeconds,
        current = 0;

  int max;

  Timer? timer;

  int current;

  bool get stopped => current == 0;

  bool banned = true;

  @mustCallSuper
  void execute() {
    current -= 1;
    update();
  }

  Future<bool> Function()? sendCode;

  @mustCallSuper
  void start() async {
    Loading.show();
    final res = await sendCode?.call();
    Loading.hide();
    if (res != true) return;

    current = max;
    execute();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      execute();
      if (current == 0) {
        stop();
      }
    });
  }

  @mustCallSuper
  void stop() {
    timer?.cancel();
    timer = null;
  }
}

class CountDownWidget extends StatelessWidget {
  const CountDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CountDownController>(
      builder: (controller) {
        final String content;
        final BoxBorder? border;
        final Color fillColor;
        final Color textColor;

        if (controller.banned) {
          fillColor = AppTheme.gray80;
          textColor = AppTheme.gray100;
          border = null;
          content = 'Code';
        } else if (controller.stopped) {
          fillColor = AppTheme.primary;
          textColor = AppTheme.gray100;
          border = null;
          content = 'Code';
        } else {
          fillColor = AppTheme.gray100;
          textColor = AppTheme.gray0;
          border = Border.all(color: AppTheme.primary, width: 2);
          content = '${controller.current}s';
        }

        return HoldButton(
          onPressed: !controller.banned && controller.stopped ? controller.start : null,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: fillColor,
              border: border,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Center(
              child: Text(
                content,
                style: AppTheme.headline5.copyWith(color: textColor),
              ),
            ),
          ),
        );
      },
    );
  }
}
