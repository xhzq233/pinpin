import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/page/home/main/home_sliver_header.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

import '../../app/assets/name.dart';
import '../../component/search_bar/search_bar.dart';
import '../../component/stateful_button/pp_image_button.dart';
import 'controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 页面布局逻辑
    final controller = Get.find<SearchController>(); //Get拿到controller里的变量
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: PinPinHomeSliverHeaderDelegate.searchBarMinHeight + 5,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Hero(
                    tag: PPHomeSearchBar.heroTag,
                    child: PPHomeSearchBar(
                      onClick: () {},
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: HoldActiveButton(
                      onPressed: () => Get.back(),
                      builder: (_) => const Text(
                        "取消",
                        style: AppTheme.headline5,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text("历史搜索"),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: PPImageButton(
                  active: AppAssets.trash_active,
                  onPressed: () {},
                ).sized(width: 40, height: 42),
              ),
            ],
          ).paddingOnly(top: 6.0, bottom: 16),
          Wrap(
            spacing: 8.0, // 主轴(水平)方向间距
            runSpacing: 4.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: const <Widget>[
              Chip(
                label: Text("大学生计算机比赛"),
              ),
              Chip(
                label: Text('美赛'),
              ),
              Chip(
                label: Text('王者荣耀'),
              ),
              Chip(
                // avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
                label: Text('大计赛'),
              ),
              Chip(
                // avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
                label: Text('美赛'),
              ),
              Chip(
                // avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
                label: Text('大计赛'),
              ),
            ],
          )
        ]).paddingSymmetric(horizontal: 18),
      ),
    );
  }
}
