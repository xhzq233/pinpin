/// pinpin - ext
/// Created by xhz on 02/08/2022

import 'dart:math';

import 'package:boxy/flex.dart';
import 'package:flutter/material.dart';
import 'package:boxy/boxy.dart';

extension WidgetExtensions on Widget {
  Widget onTap(void Function() function) => GestureDetector(
        onTap: function,
        child: this,
      );

  Widget centralized() => Center(
        child: this,
      );

  Widget overlay(Widget content, [AlignmentGeometry alignment = Alignment.center]) => CustomBoxy(
        delegate: StackWithFittingBiggestChildDelegate(),
        children: [
          BoxyId(id: #background, child: this),
          BoxyId(id: #overlay, child: content),
        ],
      );

  Widget background(Widget content, [AlignmentGeometry alignment = Alignment.center]) => Stack(
        alignment: alignment,
        fit: StackFit.passthrough,
        children: [
          content,
          this,
        ],
      );

  Widget sized({double? width, double? height}) => SizedBox(
        width: width,
        height: height,
        child: this,
      );

  Widget border({EdgeInsets? margin, EdgeInsets? padding, Color color = Colors.blueAccent}) => Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(border: Border.all(color: color)),
        child: this,
      );
}

class StackWithFittingBiggestChildDelegate extends BoxyDelegate {
  @override
  Size layout() {
    final overlay = getChild(#overlay);
    final background = getChild(#background);

    final overlaySize = overlay.layout(constraints);
    final backgroundSize = background.layout(constraints);
    BoxyColumn;Dominant;

    return Size(max(overlaySize.width, backgroundSize.width), max(overlaySize.height, backgroundSize.height));
  }
}
