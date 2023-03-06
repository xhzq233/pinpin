/// pinpin - label_switcher
/// Created by xhz on 3/6/23

import 'package:flutter/material.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:widget/button/hold.dart';

class LabelSwitcher extends StatelessWidget {
  const LabelSwitcher({
    Key? key,
    required this.selectedLabel,
    required this.selectedType,
    this.onTap,
  }) : super(key: key);

  final int selectedType;
  final int selectedLabel;
  final void Function(int index)? onTap;

  Widget _labelBuilder(BuildContext context, int index) {
    final selected = selectedLabel == index;
    final target = AppAssets.label_array[selectedType]![index];
    final imgSource = selected ? target.activeImg : target.inactiveImg;
    final bgColor = selected ? AppTheme.primary : AppTheme.gray95;
    final textColor = selected ? const Color(0xff4d94fe) : AppTheme.gray50;
    final textStyle = AppTheme.headline5;
    final List<BoxShadow> shadow = selected
        ? const [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 10,
              color: Color.fromRGBO(174, 207, 255, 0.5),
            )
          ]
        : const [];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        HoldButton(
          child: Container(
            width: 58,
            height: 58,
            margin: const EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: shadow,
            ),
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.5,
              child: Image.asset(
                imgSource,
                fit: BoxFit.fill,
              ),
            ),
          ),
          onPressed: () {
            onTap?.call(index);
          },
        ),
        Text(target.title, style: textStyle.copyWith(color: textColor), maxLines: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: AppAssets.label_array[selectedType]!.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      scrollDirection: Axis.horizontal,
      itemBuilder: _labelBuilder,
    );
  }
}
