import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/header/sliver_header_delegate.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/tab_bar/tab_bar.dart';
import 'package:pinpin/manager/api/api_interface.dart';
import 'package:pinpin/page/home/main/home_sliver_header.dart';
import 'controller.dart';
import 'package:util/util.dart';

class ReleasesPage extends StatelessWidget with PPHomeCardViewDelegate {
  ReleasesPage({Key? key}) : super(key: key);

  final controller = Get.find<ReleasesController>();

  final header = SliverPersistentHeader(
      pinned: false,
      delegate: SliverHeaderDelegate(
          maxHeight: PinPinHomeSliverHeaderDelegate.appBarMinHeight,
          minHeight: PinPinHomeSliverHeaderDelegate.appBarMinHeight,
          builder: (BuildContext context, double shrinkOffset, bool overlapsContent) {
            return const PPNavigationBar(
              title: "我发布的",
            );
          }));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PPNavigationBar(
        title: "我发布的",
        background: Color(0xFF0076FC),
        whiteAccent: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: _sliverBuilder,
          body: GetBuilder<ReleasesController>(builder: (_) => buildSliverBody()),
        ),
      ),
    );
  }

  Widget buildSliverBody() {
    return CustomScrollView(
      slivers: [
        if (controller.userInfo.value.history != null)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Slidable(
                        endActionPane: ActionPane(
                          extentRatio: 0.25,
                          motion: const ScrollMotion(),
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(left: 16, right: 15),
                              child: SizedBox(
                                width: 62,
                                height: 62,
                                child: SlidableAction(
                                  onPressed: (_) {
                                    controller.deletePinPin(controller.userInfo.value.history![index].pinpinId);
                                  },
                                  backgroundColor: AppTheme.primary,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: '删除',
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                            )
                          ],
                        ),
                        child: PPHomeCardView(
                          pp: controller.userInfo.value.history![index],
                          delegate: this,
                        ).paddingOnly(bottom: 8),
                      ),
                    ));
              },
              childCount: controller.userInfo.value.history!.length,
            ),
          )
      ],
    );
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return [
      SliverPersistentHeader(
          floating: true,
          pinned: true,
          delegate: SliverHeaderDelegate(
              maxHeight: PinPinHomeSliverHeaderDelegate.appBarMinHeight,
              minHeight: PinPinHomeSliverHeaderDelegate.appBarMinHeight,
              builder: (context, shrinkOffset, overlapsContent) => Container(
                    color: Colors.white,
                    child: const Padding(
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
                  )))
    ];
  }

  // delegates
  @override
  Future<bool> pressedFollow(int pinpinId) async {
    final res = await Get.find<PPNetWorkInterface>().followPinPin(pinPinId: pinpinId);

    if (null == res) return false;

    toast(res.msg);
    Logger.i(res.msg);
    return true;
  }
}
