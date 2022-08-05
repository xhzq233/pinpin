/// pinpin - pp_image_button
/// Created by xhz on 05/08/2022
import 'package:flutter/material.dart';
import 'hold_active_button.dart';

class PPImageButton extends StatelessWidget {
  const PPImageButton({Key? key, required this.onPressed, required this.active, required this.inactive, this.size = 30})
      : super(key: key);
  final ButtonOnPressed onPressed;
  final String inactive;
  final String active;
  final double size;

  @override
  Widget build(BuildContext context) {
    return HoldActiveButton(
      builder: (HAButtonState state) {
        if (state == HAButtonState.active) {
          return Image.asset(
            active,
            height: size,
            fit: BoxFit.fitHeight,
          );
        } else {
          return Image.asset(
            inactive,
            height: size,
            fit: BoxFit.fitHeight,
          );
        }
      },
      onPressed: onPressed,
    );
  }
}
