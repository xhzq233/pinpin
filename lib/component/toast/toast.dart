/// pinpin - toast
/// Created by xhz on 27/07/2022

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../manager/platform/platform_api.dart';
import '../../util/pair.dart';

toast(String str, {int delay = 4}) {
  if (str.isEmpty) return;

  if (Platform.isAndroid) {
    PlatformApi.toast(str, isLong: delay > 4);
    return;
  }

  OverlayEntry overlayEntry = OverlayEntry(
      builder: (_) => Align(
        alignment: const Alignment(0, 0.69),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Text(
              str,
              // style: const TextStyle(color: Global.cbOnBackground),
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
