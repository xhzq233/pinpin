import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:util/logger.dart';

const NavigationBarHeight = 41.0;
late WindowPadding physicalPadding;
late double devicePixelRatio;
late EdgeInsets windowPadding;
late Size screenSize;

windowsPaddingInit() {
  initDevice() {
    //init device info
    physicalPadding = window.padding;
    devicePixelRatio = window.devicePixelRatio;
    windowPadding = EdgeInsets.only(
      top: physicalPadding.top / devicePixelRatio,
      left: physicalPadding.left / devicePixelRatio,
      bottom: physicalPadding.bottom / devicePixelRatio,
      right: physicalPadding.right / devicePixelRatio,
    );
    screenSize = Size(window.physicalSize.width / devicePixelRatio, window.physicalSize.height / devicePixelRatio);

    Logger.i('[onMetricsChanged], windowPadding=$windowPadding, screenSize=$screenSize');
  }

  initDevice();

  //listen window padding change
  final old = WidgetsBinding.instance.platformDispatcher.onMetricsChanged;
  WidgetsBinding.instance.platformDispatcher.onMetricsChanged = () {
    initDevice();
    old?.call();
  };
}
