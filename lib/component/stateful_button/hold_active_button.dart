/// pinpin - hold_active_button
/// Created by xhz on 05/08/2022

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinpin/util/logger.dart';

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

class _HoldActiveButtonState extends State<HoldActiveButton> with SingleTickerProviderStateMixin {
  bool get isEnabled => widget.onPressed != null;

  late HAButtonState oldState = state;
  static const Duration kFadeOutDuration = Duration(milliseconds: 120);
  static const Duration kFadeInDuration = Duration(milliseconds: 180);

  HAButtonState get state =>
      isEnabled ? (pressed ? HAButtonState.active : HAButtonState.inactive) : HAButtonState.banned;

  late final AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation =
        _animationController.drive(CurveTween(curve: Curves.decelerate)).drive(Tween(begin: 1.0, end: 0.4));
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animate() {
    if (_animationController.isAnimating) {
      return;
    }
    final bool wasHeldDown = pressed;
    final TickerFuture ticker = pressed
        ? _animationController.animateTo(1.0, duration: kFadeOutDuration, curve: Curves.easeInOutCubicEmphasized)
        : _animationController.animateTo(0.0, duration: kFadeInDuration, curve: Curves.easeOutCubic);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != pressed) {
        _animate();
      }
    });
  }

  Widget _buildChild() {
    Widget child = Opacity(
      opacity: _opacityAnimation.value,
      child: widget.builder(state),
    );
    // return FadeTransition(
    //   opacity: _opacityAnimation,
    //   child: widget.builder(state),
    // );
    return child;
  }

  @override
  Widget build(BuildContext context) {
    AnimatedSwitcher;
    return GestureDetector(
      onTapDown: (_) {
        if (!pressed) {
          pressed = true;
          _animate();
        }
      },
      onTapUp: (_) {
        if (pressed) {
          pressed = false;
          _animate();
        }
      },
      onTapCancel: () {
        if (pressed) {
          pressed = false;
          _animate();
        }
      },
      onTap: widget.onPressed,
      child: _buildChild(),
    );
  }

  bool pressed = false;
}
