/// pinpin - hold
/// Created by xhz on 3/5/23

import 'package:flutter/material.dart';

typedef ButtonOnPressed = void Function();

class HoldButton extends StatefulWidget {
  const HoldButton({Key? key, required this.child, this.onPressed}) : super(key: key);

  final Widget child;
  final ButtonOnPressed? onPressed;

  @override
  State<HoldButton> createState() => _HoldButtonState();
}

class _HoldButtonState extends State<HoldButton> with SingleTickerProviderStateMixin {
  // bool get isEnabled => widget.onPressed != null;

  static const Duration kFadeOutDuration = Duration(milliseconds: 120);
  static const Duration kFadeInDuration = Duration(milliseconds: 180);

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
        _animationController.drive(CurveTween(curve: Curves.decelerate)).drive(Tween(begin: 1.0, end: 0.56));
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
    // if (!isEnabled) {
    //   return widget.child;
    // }
    return FadeTransition(
      opacity: _opacityAnimation,
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: MouseRegion(
        cursor: MaterialStateMouseCursor.clickable,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
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
          onTapCancel: () async {
            if (pressed) {
              pressed = false;
              _animate();
            }
          },
          onTap: widget.onPressed,
          child: _buildChild(),
        ),
      ),
    );
  }

  bool pressed = false;
}
