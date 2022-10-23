import 'dart:ui';
import 'package:flutter/material.dart';

const PPNavigationBarHeight = 41.0;
final physicalPadding = window.padding;
final devicePixelRatio = window.devicePixelRatio;

final windowPadding = EdgeInsets.only(
  top: physicalPadding.top / devicePixelRatio,
  left: physicalPadding.left / devicePixelRatio,
  bottom: physicalPadding.bottom / devicePixelRatio,
  right: physicalPadding.right / devicePixelRatio,
);
