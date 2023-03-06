/// pinpin - pp_common_text_button
/// Created by xhz on 2022/8/5
import 'package:flutter/material.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:util/util.dart';
import 'hold_active_button.dart';

enum PPCommonTextButtonStyle { fill, outline }

enum PPCommonTextButtonSize {
  normal(330, 56),
  secondary(276, 50),
  tertiary(84, 36),
  quaternary(68, 32);

  final double height;
  final double width;

  const PPCommonTextButtonSize(this.width, this.height);
}

class PPCustomCapsuleButton extends StatelessWidget {
  const PPCustomCapsuleButton(
      {Key? key,
      this.onPressed = empty,
      required this.child,
      this.background = AppTheme.primary,
      this.contentPadding = const EdgeInsets.symmetric(vertical: 2, horizontal: 9)})
      : super(key: key);
  final Widget child;
  final ButtonOnPressed onPressed;
  final Color background;
  final EdgeInsets contentPadding;

  static void empty() {}

  @override
  Widget build(BuildContext context) {
    return HoldActiveButton(
      onPressed: onPressed,
      builder: (_) => ClipPath(
        clipper: const CapsuleClipper(),
        child: DecoratedBox(
          decoration: BoxDecoration(color: background),
          child: Padding(
            padding: contentPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}

class PPCommonTextButton extends StatelessWidget {
  const PPCommonTextButton(
      {Key? key,
      this.onPressed,
      required this.title,
      this.size = PPCommonTextButtonSize.normal,
      this.style = PPCommonTextButtonStyle.fill})
      : super(key: key);
  final ButtonOnPressed? onPressed;
  final String title;
  final PPCommonTextButtonSize size;
  final PPCommonTextButtonStyle style;

  static const basic = BoxDecoration(boxShadow: [AppTheme.shadow], borderRadius: BorderRadius.all(Radius.circular(15)));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: HoldActiveButton(
          builder: (HAButtonState state) {
            BoxDecoration boxDecoration;
            final Color color;
            final Color textColor;
            switch (state) {
              case HAButtonState.active:
                color = AppTheme.primary;
                break;
              case HAButtonState.banned:
                color = AppTheme.banned;
                break;
            }
            if (style == PPCommonTextButtonStyle.outline) {
              boxDecoration = basic.copyWith(border: Border.all(color: color, width: 1.7), color: Colors.white);
              textColor = AppTheme.primary;
            } else {
              boxDecoration = basic.copyWith(color: color);
              textColor = Colors.white;
            }
            if (size == PPCommonTextButtonSize.normal) {
              boxDecoration = boxDecoration.copyWith(borderRadius: const BorderRadius.all(Radius.circular(20)));
            }
            final text = Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: AppTheme.headline5.copyWith(color: textColor),
              ),
            );

            return DecoratedBox(decoration: boxDecoration, child: text);
          },
          onPressed: onPressed,
        ),
      ),
    );
  }
}
