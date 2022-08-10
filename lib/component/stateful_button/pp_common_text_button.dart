/// pinpin - pp_common_text_button
/// Created by xhz on 2022/8/5
import 'package:flutter/material.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
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
    final text = Align(
      alignment: Alignment.center,
      child: Text(
        title,
        style: AppTheme.headline5,
      ),
    );

    return Center(
      child: HoldActiveButton(
        builder: (HAButtonState state) {
          BoxDecoration boxDecoration;
          final Color color;
          switch (state) {
            case HAButtonState.active:
              color = AppTheme.secondary4;
              break;
            case HAButtonState.inactive:
              color = AppTheme.primary;
              break;
            case HAButtonState.banned:
              color = AppTheme.banned;
              break;
          }
          if (style == PPCommonTextButtonStyle.outline) {
            boxDecoration = basic.copyWith(border: Border.all(color: color, width: 1.7), color: Colors.white);
          } else {
            boxDecoration = basic.copyWith(color: color);
          }
          if (size == PPCommonTextButtonSize.normal) {
            boxDecoration = boxDecoration.copyWith(borderRadius: const BorderRadius.all(Radius.circular(20)));
          }
          return text.decorated(boxDecoration);
        },
        onPressed: onPressed,
      ).sized(width: size.width, height: size.height),
    );
  }
}
