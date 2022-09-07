/// pinpin - pp_image_button
/// Created by xhz on 05/08/2022
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'hold_active_button.dart';

class PPImageButton extends StatelessWidget {
  PPImageButton(
      {super.key,
      required this.onPressed,
      required String active,
      required String inactive,
      double size = 30,
      double padding = 10}) {
    _inactive = Image.asset(
      inactive,
      height: size,
      fit: BoxFit.fitHeight,
    ).paddingAll(padding);

    _active = Image.asset(
      active,
      height: size,
      fit: BoxFit.fitHeight,
    ).paddingAll(padding);
  }

  PPImageButton.fromImage(Widget data, {super.key, required this.onPressed, double padding = 10}) {
    _inactive = data.paddingAll(padding);
    _active = data.paddingAll(padding);
  }

  final ButtonOnPressed onPressed;
  late final Widget _inactive;
  late final Widget _active;

  @override
  Widget build(BuildContext context) {
    return HoldActiveButton(
      builder: (HAButtonState state) {
        if (state == HAButtonState.active) {
          return _active;
        } else {
          return _inactive;
        }
      },
      onPressed: onPressed,
    );
  }
}
