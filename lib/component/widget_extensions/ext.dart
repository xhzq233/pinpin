/// pinpin - ext
/// Created by xhz on 02/08/2022

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:boxy/boxy.dart';
import 'package:pinpin/util/clipper.dart';

extension WidgetExtensions on Widget {
  static void emptyCallback() {}

  Widget blur([double sigma = 10]) => ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
          child: this,
        ),
      );

  Widget onTap(void Function() function) => GestureDetector(
        onTap: function,
        child: this,
      );

  Widget centralized() => Center(
        child: this,
      );

  Widget overlay(Widget content) => CustomBoxy(
        delegate: AdaptiveOverlayDelegate(),
        children: [
          BoxyId(id: #overlaid, child: this),
          BoxyId(id: #overlay, child: content),
        ],
      );

  Widget background(Widget content) => CustomBoxy(
        delegate: AdaptiveBackgroundDelegate(),
        children: [
          BoxyId(id: #background, child: content),
          BoxyId(id: #foreground, child: this),
        ],
      );

  Widget decorated(BoxDecoration boxDecoration) => DecoratedBox(
        decoration: boxDecoration,
        child: this,
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

  Widget clipped([BorderRadius? borderRadius]) => ClipRRect(
        borderRadius: borderRadius,
        child: this,
      );

  Widget clip([
    CustomClipper<Path> clipper = const CapsuleClipper(),
  ]) =>
      ClipPath(
        clipper: clipper,
        child: this,
      );

  Widget unconstrained() => UnconstrainedBox(
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
    final foreground = getChild(#foreground);
    final background = getChild(#background);
    final foregroundSize = foreground.layout(constraints);
    final backgroundConstraints =
        constraints.copyWith(minHeight: foregroundSize.height, minWidth: foregroundSize.width);
    final backgroundSize = background.layout(backgroundConstraints);

    return Size(max(foregroundSize.width, backgroundSize.width), max(foregroundSize.height, backgroundSize.height));
  }
}
