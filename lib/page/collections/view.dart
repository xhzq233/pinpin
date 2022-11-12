import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/blue_static_header.dart';
import 'package:pinpin/component/header/home_sliver_header.dart';
import 'package:pinpin/component/header/sliver_header_delegate.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/tab_bar/tab_bar.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';

import 'controller.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 页面布局逻辑
    final controller = Get.find<CollectionsController>();

    final pinpin = PinPin(
        pinpinId: 1,
        type: 2,
        label: 3,
        title: "hello world",
        deadline: DateTime.now(),
        demandingNum: 100,
        nowNum: 10,
        ownerEmail: "U202013777",
        updatedAt: 555,
        isFollowed: true);

    final header = SliverPersistentHeader(
      pinned: true,
        delegate: SliverHeaderDelegate(
            maxHeight: PinPinHomeSliverHeaderDelegate.appBarMinHeight,
            minHeight: PinPinHomeSliverHeaderDelegate.appBarMinHeight,
            builder: (BuildContext context, double shrinkOffset, bool overlapsContent) {
              return const PPNavigationBar(title: "我的收藏",);
            }
        )
    );

    return Scaffold(
        body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (_, __) => [
                header,
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: TabBarWidget(
                      isScrollable: true,
                      indicatorMinWidth: 24,
                      padding: EdgeInsets.only(right: 130, top: 10),
                      indicator: RRecTabIndicator(radius: 4),
                      tabs: [
                        Text('默认排序', style: AppTheme.headline6, maxLines: 1),
                        Text('未拼满', style: AppTheme.headline6, maxLines: 1),
                      ],
                    ),
                  ),
                ),
              ],
              body: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  itemCount: 100,
                  prototypeItem:
                      PPHomeCardView(pp: pinpin).paddingOnly(bottom: 8),
                  //prototype
                  itemBuilder: (context, index) {
                    return PPHomeCardView(pp: pinpin).paddingOnly(bottom: 8);
                  }),
            )));
  }
}
