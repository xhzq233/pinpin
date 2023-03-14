/// pinpin - view
/// Created by xhz on 07/08/2022

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/switcher/label_switcher.dart';
import 'package:pinpin/page/home/main/home_sliver_header.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/list_view/load_more_list.dart';
import 'package:pinpin/component/tab_bar/tab_bar.dart';
import 'package:util/util.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'controller.dart';

class PPHomeMainView extends StatefulWidget {
  const PPHomeMainView({Key? key}) : super(key: key);

  @override
  State<PPHomeMainView> createState() => _PPHomeMainViewState();
}

class _PPHomeMainViewState extends State<PPHomeMainView> with SingleTickerProviderStateMixin {
  Widget _itemBuilder(BuildContext context, PinPin item, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      child: PPHomeCardView(
        pp: item,
        delegate: controller,
      ).onTap(
        () => Get.toNamed(RN.pp_detail, arguments: item),
      ),
    );
  }

  final controller = Get.find<PPHomeMainController>();
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      // Logger.i(tabController.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listView(type) => Column(
          children: [
            SizedBox(
              height: 85 + 8 * 2,
              child: Obx(
                () => LabelSwitcher(
                  selectedLabelIndex: controller.selectedLabelIndex[type]!.value,
                  selectedType: type,
                  onTap: (index) => controller.selectedLabelIndex[type]!.value = index,
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => LoadMoreListView(
                  sourceList: controller.getSource(type),
                  itemBuilder: _itemBuilder,
                ),
              ),
            ),
          ],
        );

    return NestedScrollView(
      body: TabBarView(
        controller: tabController,
        physics: const BouncingScrollPhysics(),
        children: [
          listView(PinPin.ppt_ett),
          listView(PinPin.ppt_study),
        ],
      ),
      headerSliverBuilder: (_, __) => [
        const SliverPersistentHeader(
          pinned: true,
          delegate: PinPinHomeSliverHeaderDelegate(),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TabBarWidget(
              controller: tabController,
              isScrollable: true,
              indicatorMinWidth: 24,
              padding: const EdgeInsets.only(right: 130, top: 10),
              indicator: const RRecTabIndicator(radius: 4),
              tabs: const [
                Text('娱乐拼', style: AppTheme.headline6, maxLines: 1),
                Text('学习拼', style: AppTheme.headline6, maxLines: 1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
