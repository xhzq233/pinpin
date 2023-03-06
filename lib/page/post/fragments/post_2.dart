/// pinpin - view
/// Created by xhz on 2022/8/8
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
import 'package:pinpin/page/post/logic.dart';
import 'package:util/util.dart';

class PPPost2Fragment extends StatelessWidget {
  const PPPost2Fragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<PPPostLogic>();
    const padding = SizedBox(height: 8, width: 6);
    final TextStyle textStyle = AppTheme.headline7.copyWith(color: AppTheme.gray50);

    final qty = [
      for (var i in [logic.qty1, logic.qty2])
        SizedBox(
          width: 36,
          child: PPTextField(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            hintText: '-',
            style: AppTheme.headline7,
            textFieldStyle: PPTextFieldStyle.backgroundFilled,
            textAlign: TextAlign.center,
            radius: 8,
            controller: i,
            limitations: [Validators.maxNNumber(2)],
          ),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('人员需求', style: AppTheme.headline6),
        padding,
        Row(
          children: [
            Text('需要', style: textStyle),
            padding,
            qty[0],
            padding,
            Text('人       已有', style: textStyle),
            padding,
            qty[1],
            padding,
            Text('人', style: textStyle),
          ],
        ),
        padding,
        const Text('人员需求情况', style: AppTheme.headline6),
        padding,
        PPTextField(
          textFieldStyle: PPTextFieldStyle.backgroundFilled,
          maxLines: 10,
          hintText: '选填，不超过200字，介绍一下你所需人员的性别、技能等吧',
          maxLength: 200,
          controller: logic.qtyInfo,
        ),
      ],
    );
  }
}
