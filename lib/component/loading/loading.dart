/// pinpin - loading
/// Created by xhz on 27/07/2022

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loading {
  static final _entry = OverlayEntry(
    builder: (_) => Container(
        color: Colors.black12,
        child: const RepaintBoundary(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )),
  );
  static bool _showing = false;

  static void show() {
    if (_showing) return;
    final context = Get.overlayContext;
    if (context != null) {
      Overlay.of.call(context)?.insert(_entry);
    }
    _showing = true;
  }

  static void hide() {
    if (!_showing) return;
    _entry.remove();
    _showing = false;
  }
}
