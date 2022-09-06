/// pinpin - view
/// Created by xhz on 07/08/2022

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/home_sliver_header.dart';
import 'package:pinpin/component/header/refresh_header.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/list_view/load_more_list.dart';
import 'package:pinpin/component/stateful_button/pp_common_text_button.dart';
import 'package:pinpin/component/switcher/switcher.dart';
import 'package:pinpin/component/tab_bar/tab_bar.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:pinpin/page/pp_detail/view.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'controller.dart';

class PPHomeMainView extends GetView<PPHomeMainController> {
  const PPHomeMainView({Key? key}) : super(key: key);

  Widget _itemBuilder(BuildContext context, PinPin item, int index) {
    return PPSwitcher(
      rxIndex: 0.obs,
      titles: const ['闭嘴','雪豹',],
      height: 60,
      width: 200,
    );
    // return Hero(
    //     tag: 'pp_${item.pinpinId}',
    //     child: PPHomeCardView(
    //       pp: item,
    //     )).onTap(() => Get.toNamed(RN.pp_detail, arguments: item)).paddingSymmetric(vertical: 5);
  }

  Widget _itemBuilder2(BuildContext context, PinPin item, int index) {
    return PPOutLineTextField(hintText: 'Input your student ID',suffixText: '@hust.edu.cn',);
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
                  AutoUnFocusWrap(
                      child: LoadMoreListView(
                          sourceList: controller.source,
                          padding: const EdgeInsets.symmetric(horizontal: 19.0),
                          itemBuilder: _itemBuilder2)),
                  LoadMoreListView(sourceList: controller.source, itemBuilder: _itemBuilder)
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
                        indicator: RRecTabIndicator(
                          radius: 4,
                        ),
                        tabs: [
                          Text(
                            'Entertainment',
                            style: TextStyle(color: Colors.black),
                            maxLines: 1,
                          ),
                          Text(
                            'Study',
                            style: TextStyle(color: Colors.black),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    )),
                PullToRefreshContainer((info) => PullToRefreshHeader(info: info)),
              ])));
}
