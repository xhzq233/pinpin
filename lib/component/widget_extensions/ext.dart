/// pinpin - ext
/// Created by xhz on 02/08/2022

import 'dart:math';
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
        delegate: AdaptiveOverlayDelegate(),
        children: [
          BoxyId(id: #overlaid, child: this),
          BoxyId(id: #overlay, child: content),
        ],
      );

  Widget background(Widget content, [AlignmentGeometry alignment = Alignment.center]) => CustomBoxy(
        delegate: AdaptiveBackgroundDelegate(),
        children: [
          BoxyId(id: #background, child: content),
          BoxyId(id: #foreground, child: this),
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

class AdaptiveOverlayDelegate extends BoxyDelegate {
  @override
  Size layout() {
    final overlay = getChild(#overlay);
    final background = getChild(#overlaid);

    final backgroundSize = background.layout(constraints);
    final overlayConstraints = constraints.copyWith(minHeight: backgroundSize.height, minWidth: backgroundSize.width);
    final overlaySize = overlay.layout(overlayConstraints);

    return Size(max(overlaySize.width, backgroundSize.width), max(overlaySize.height, backgroundSize.height));
  }
}

class AdaptiveBackgroundDelegate extends BoxyDelegate {
  @override
  Size layout() {
    final overlay = getChild(#foreground);
    final background = getChild(#background);
    final overlaySize = overlay.layout(constraints);
    final backgroundConstraints = constraints.copyWith(minHeight: overlaySize.height, minWidth: overlaySize.width);
    final backgroundSize = background.layout(backgroundConstraints);

    return Size(max(overlaySize.width, backgroundSize.width), max(overlaySize.height, backgroundSize.height));
  }
}
