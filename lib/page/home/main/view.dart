/// pinpin - view
/// Created by xhz on 07/08/2022

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/home_sliver_header.dart';
import 'package:pinpin/component/header/refresh_header.dart';
import 'package:pinpin/component/list_view/load_more_list.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/component/tab_bar/tab_bar.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'controller.dart';

class PPHomeMainView extends GetView<PPHomeMainController> {
  const PPHomeMainView({Key? key}) : super(key: key);

  Widget _itemBuilder(BuildContext context, PinPin item, int index) {
    return PPCommonTextButton(onPressed: () {}, title: item.title).paddingAll(20);
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: PullToRefreshNotification(
          onRefresh: () async => await controller.source.refresh(true),
          maxDragOffset: 100,
          child: NestedScrollView(
              body: TabBarView(
                children: [
                  LoadMoreListView(sourceList: controller.source, itemBuilder: _itemBuilder),
                  LoadMoreListView(sourceList: controller.source, itemBuilder: _itemBuilder)
                ],
              ),
              headerSliverBuilder: (_, __) => [
                    const SliverPersistentHeader(
                      pinned: true,
                      delegate: PinPinHomeSliverHeaderDelegate(),
                    ),
                    const SliverToBoxAdapter(
                        child: TabBarWidget(
                      indicatorMinWidth: 15,
                      padding: EdgeInsets.only(right: 150, top: 10),
                      indicator: RRecTabIndicator(
                        radius: 4,
                      ),
                      tabs: [
                        Text(
                          'Entertainment',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          'Study',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    )),
                    PullToRefreshContainer((info) => PullToRefreshHeader(info: info)),
                  ])));
}
