/// pinpin - hold_active_button
/// Created by xhz on 05/08/2022

import 'package:flutter/material.dart';

typedef ButtonOnPressed = void Function();
typedef ButtonContentBuilder = Widget Function(HAButtonState);

enum HAButtonState { active, inactive, banned }

class HoldActiveButton extends StatefulWidget {
  const HoldActiveButton({Key? key, required this.builder, this.onPressed}) : super(key: key);

  final ButtonContentBuilder builder;
  final ButtonOnPressed? onPressed;

  @override
  State<HoldActiveButton> createState() => _HoldActiveButtonState();
}

class _HoldActiveButtonState extends State<HoldActiveButton> {
  bool get isEnabled => widget.onPressed != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detail) {
        hasTapUp = false;
        if (isEnabled && !pressed) {
          pressed = true;
          setState(() {});
        }
      },
      onTapUp: (details) {
        if (isEnabled) {
          widget.onPressed!();
        }
        hasTapUp = true;
        _resetIfTapUp();
      },
      onTapCancel: () {
        hasTapUp = true;
        _resetIfTapUp();
      },
      child:
          widget.builder(isEnabled ? (pressed ? HAButtonState.active : HAButtonState.inactive) : HAButtonState.banned),
    );
  }

  bool pressed = false;

  //used to stay pressed if no tap up
  void _resetIfTapUp() async {
    if (hasTapUp == true) {
      await Future.delayed(const Duration(milliseconds: 84)); //five frame
      setState(() {
        pressed = false;
        hasTapUp = false;
      });
    }
  }

  bool hasTapUp = false;
}
