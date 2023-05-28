import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/component/home_pp_card/home_pp_card.dart';
import 'package:pinpin/component/list_view/load_more_list.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';
import 'package:pinpin/page/search/controller.dart';
import 'package:pinpin/page/search/search_result/component/pp_search_tabbar.dart';
import 'package:util/util.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;
  final controller = Get.find<PPSearchController>();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: _tabIndex);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    listView(type) => Obx(
          () => LoadMoreListView(
        sourceList: controller.getSource(type),
        itemBuilder: _itemBuilder,
      ),
    );

    return Column(
      children: [
        Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 12).add(const EdgeInsets.only(top: 20)),
          alignment: Alignment.centerLeft,
          child: PPSearchTabBar(
              selectIndex: _tabIndex,
              switchTab: (index) {
                _tabController.animateTo(index);
                setState(() {
                  _tabIndex = index;
                });
              }
          )
        ),
        Flexible(
          child: TabBarView(
            controller: _tabController,
              physics: const BouncingScrollPhysics(),
              children: [
                listView(PinPin.ppt_ett),
                listView(PinPin.ppt_study),
              ]
          ),
        )
      ],
    );
  }

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
}
