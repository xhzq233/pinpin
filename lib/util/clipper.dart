/// pinpin - clipper
/// Created by xhz on 2022/8/8
import 'dart:math';
import 'package:flutter/material.dart';

class CapsuleClipper extends CustomClipper<Path> {
  const CapsuleClipper({Listenable? reclip}) : super(reclip: reclip);

  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;

    final radius = min(height, width);

    return Path()
      ..addRRect(RRect.fromRectAndRadius(Rect.fromPoints(Offset.zero, Offset(width, height)), Radius.circular(radius)));
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
