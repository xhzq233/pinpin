/// pinpin - view
/// Created by xhz on 07/08/2022

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/page/home/main/home_sliver_header.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/list_view/load_more_list.dart';
import 'package:pinpin/component/tab_bar/tab_bar.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'controller.dart';

class PPHomeMainView extends GetView<PPHomeMainController> {
  const PPHomeMainView({Key? key}) : super(key: key);

  Widget _itemBuilder(BuildContext context, PinPin item, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Hero(
        tag: 'pp_${item.pinpinId}',
        child: PPHomeCardView(pp: item),
      ).onTap(
        () => Get.toNamed(RN.pp_detail, arguments: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            LoadMoreListView(
              sourceList: controller.source,
              itemBuilder: _itemBuilder,
            ),
            LoadMoreListView(
              sourceList: controller.source2,
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
                  Text('Entertainment', style: AppTheme.headline6, maxLines: 1),
                  Text('Study', style: AppTheme.headline6, maxLines: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
