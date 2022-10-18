/// pinpin - toast
/// Created by xhz on 27/07/2022

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';

import '../../manager/platform/platform_api.dart';
import '../../util/pair.dart';

void toast(String str, {int delay = 3}) {
  if (str.isEmpty) return;

  if (GetPlatform.isAndroid) {
    PlatformApi.toast(str, isLong: delay > 4);
    return;
  }

  OverlayEntry overlayEntry = OverlayEntry(
      builder: (_) => Align(
            alignment: const Alignment(0, 0.69),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                  color: AppTheme.gray100,
                  boxShadow: [AppTheme.shadow],
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Text(
                  str,
                  style: AppTheme.headline6.copyWith(inherit: false),
                ),
              ),
            ),
          ));
  _ToastQueue.push(Pair(delay, overlayEntry));
}

typedef _ToastQueueValue = Pair<int, OverlayEntry>;

class _ToastQueue {
  static final List<_ToastQueueValue> _queue = [];
  static bool _isRunning = false;

  static void push(_ToastQueueValue value) {
    _queue.add(value);
    if (!_isRunning) _boost();
  }

  static void _boost() async {
    _isRunning = true;
    while (_queue.isNotEmpty) {
      final i = _queue.removeAt(0);
      final context = Get.overlayContext;
      if (context != null) {
        Overlay.of.call(context)?.insert(i.second);
      }
      await i.first.delay();
      i.second.remove();
    }
    _isRunning = false;
  }
}
