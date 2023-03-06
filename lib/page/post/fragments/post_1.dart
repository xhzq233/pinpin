/// pinpin - view
/// Created by xhz on 2022/8/8
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';
import 'package:pinpin/component/switcher/switcher.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:pinpin/page/post/logic.dart';
import 'package:util/util.dart';

class PPPost1Fragment extends StatelessWidget {
  const PPPost1Fragment({Key? key}) : super(key: key);

  Widget _labelBuilder(BuildContext context, int index) => Obx(
        () {
          final controller = Get.find<PPPostLogic>();

          final selected = controller.selectedLabel.value == index;
          final target = AppAssets.label_array[controller.selectedType.value]![index];
          final imgSource = selected ? target.activeImg : target.inactiveImg;
          final bgColor = selected ? AppTheme.primary : AppTheme.gray95;
          final textColor = selected ? const Color(0xff4d94fe) : AppTheme.gray50;
          final textStyle = selected ? AppTheme.headline4 : AppTheme.headline5;
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
              HoldActiveButton(
                  builder: (_) => Container(
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
                    controller.selectedLabel.value = index;
                  }),
              Text(target.title, style: textStyle.copyWith(color: textColor), maxLines: 1),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<PPPostLogic>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('模块选择', style: AppTheme.headline6),
        PPSwitcher(
          width: 159,
          height: 30,
          rxIndex: logic.selectedType,
          titles: const {PinPin.ppt_ett: '娱乐拼', PinPin.ppt_study: '学习拼'},
          fontScale: 0.6,
        ),
        const Text('标签选择', style: AppTheme.headline6),
        SizedBox(
          height: 96,
          child: ListView.builder(
            itemCount: AppAssets.label_array[logic.selectedType]!.length,
            padding: const EdgeInsets.symmetric(vertical: 8),
            scrollDirection: Axis.horizontal,
            itemBuilder: _labelBuilder,
          ),
        ),
        const Text('拼拼标题', style: AppTheme.headline6),
        PPTextField(
          textFieldStyle: PPTextFieldStyle.backgroundFilled,
          hintText: '请输入标题名称',
          controller: logic.title,
          validator: Validators.cannotEmpty,
        ),
        const Text('活动概述', style: AppTheme.headline6),
        PPTextField(
          textFieldStyle: PPTextFieldStyle.backgroundFilled,
          maxLines: 5,
          maxLength: 100,
          hintText: '选填，不超过100字，介绍一下你求拼的事件~',
          controller: logic.summary,
        ),
      ],
    );
  }
}
