/// pinpin - view
/// Created by xhz on 07/08/2022

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';
import 'package:pinpin/component/switcher/label_switcher.dart';
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

  @override
  Widget build(BuildContext context) {
    final labels = SizedBox(
      height: 85 + 8 * 2,
      child: Obx(
        () => LabelSwitcher(
          selectedLabel: controller.selectedLabel.value,
          selectedType: controller.selectedType.value,
          onTap: (index) => controller.selectedLabel.value = index,
        ),
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
