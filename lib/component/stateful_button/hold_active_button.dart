/// pinpin - hold_active_button
/// Created by xhz on 05/08/2022

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef ButtonOnPressed = void Function();
typedef ButtonContentBuilder = Widget Function(HAButtonState);

enum HAButtonState { active, banned }

class HoldActiveButton extends StatefulWidget {
  const HoldActiveButton({Key? key, required this.builder, this.onPressed}) : super(key: key);

  final ButtonContentBuilder builder;
  final ButtonOnPressed? onPressed;

  @override
  State<HoldActiveButton> createState() => _HoldActiveButtonState();
}

class _HoldActiveButtonState extends State<HoldActiveButton> with SingleTickerProviderStateMixin {
  bool get isEnabled => widget.onPressed != null;

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
    if (!isEnabled) {
      return widget.builder(HAButtonState.banned);
    }
    return FadeTransition(
      opacity: _opacityAnimation,
      child: widget.builder(HAButtonState.active),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
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
    );
  }

  bool pressed = false;
}

// class _HoldActiveButtonState extends State<HoldActiveButton> {
//   bool get isEnabled => widget.onPressed != null;
//
//   HAButtonState get state =>
//       isEnabled ? (pressed ? HAButtonState.active : HAButtonState.inactive) : HAButtonState.banned;
//
//   void _animate() {
//     setState(() {});
//   }
//
//   Widget _buildChild() {
//     return widget.builder(state);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RepaintBoundary(
//       child: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTapDown: (_) {
//           if (!pressed) {
//             pressed = true;
//             _animate();
//           }
//         },
//         onTapUp: (_) {
//           if (pressed) {
//             pressed = false;
//             _animate();
//           }
//         },
//         onTapCancel: () async {
//           if (pressed) {
//             pressed = false;
//             _animate();
//           }
//         },
//         onTap: widget.onPressed,
//         child: _buildChild(),
//       ),
//     );
//   }
//
//   bool pressed = false;
// }
