/// pinpin - toast
/// Created by xhz on 27/07/2022

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:util/platform_api.dart';

void toast(String str, {int delay = 4}) {
  if (str.isEmpty) return;

  if (Platform.isAndroid) {
    PlatformApi.toast(str, isLong: delay > 4);
    return;
  }

  OverlayEntry overlayEntry = OverlayEntry(
    builder: (_) => Align(
      alignment: const Alignment(0, 0.69),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(28)),
          boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 16, offset: Offset(0, 4))],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Text(
            str,
            style: const TextStyle(
              fontSize: 12,
              decoration: TextDecoration.none,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: '.SF UI Display',
              inherit: false,
            ),
          ),
        ),
      ),
    ),
  );
  _ToastQueue.push(_ToastQueueValue(delay, overlayEntry));
}

class _ToastQueueValue {
  const _ToastQueueValue(this.delay, this.overlayEntry);

  final int delay;
  final OverlayEntry overlayEntry;
}

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
        Overlay.of(context).insert(i.overlayEntry);
      }
      await i.delay.delay();
      i.overlayEntry.remove();
    }
    _isRunning = false;
  }
}
