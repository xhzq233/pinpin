/// pinpin - view
/// Created by xhz on 07/08/2022

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';
import 'package:pinpin/page/home/main/home_sliver_header.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/list_view/load_more_list.dart';
import 'package:pinpin/component/tab_bar/tab_bar.dart';
import 'package:util/util.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'controller.dart';

class PPHomeMainView extends GetView<PPHomeMainController> {
  const PPHomeMainView({Key? key}) : super(key: key);

  Widget _itemBuilder(BuildContext context, PinPin item, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: PPHomeCardView(pp: item).onTap(
        () => Get.toNamed(RN.pp_detail, arguments: item),
      ),
    );
  }

  Widget _labelBuilder(BuildContext context, int index) => Obx(
        () {
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
    final labels = SizedBox(
      height: 85 + 8 * 2,
      child: ListView.builder(
        itemCount: 20,
        padding: const EdgeInsets.symmetric(vertical: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: _labelBuilder,
      ),
    );
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                labels,
                Expanded(
                  child: LoadMoreListView(
                    sourceList: controller.entertainmentSource,
                    itemBuilder: _itemBuilder,
                  ),
                ),
              ],
            ),
            LoadMoreListView(
              sourceList: controller.studySource,
              itemBuilder: _itemBuilder,
            ),
          ],
        ),
        headerSliverBuilder: (_, __) => [
          const SliverPersistentHeader(
            pinned: true,
            delegate: PinPinHomeSliverHeaderDelegate(),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TabBarWidget(
                isScrollable: true,
                indicatorMinWidth: 24,
                padding: EdgeInsets.only(right: 130, top: 10),
                indicator: RRecTabIndicator(radius: 4),
                tabs: [
                  Text('娱乐拼', style: AppTheme.headline6, maxLines: 1),
                  Text('学习拼', style: AppTheme.headline6, maxLines: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
