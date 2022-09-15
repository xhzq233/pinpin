import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';

import '../../app/assets/name.dart';
import '../../component/search_bar/search_bar.dart';
import '../../component/stateful_button/pp_image_button.dart';
import 'controller.dart';

class SearchPage extends GetView<SearchController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 页面布局逻辑
    final controller = Get.find<SearchController>(); //Get拿到controller里的变量
    return Scaffold(
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 390,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // const DecoratedBox(
                    //   decoration: BoxDecoration(
                    //       color: Colors.blue),
                    // ),
                    Align(
                      alignment: const Alignment(-0.6, 0),
                      child:
                          const PPHomeSearchBar().sized(width: 350, height: 40),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 60,
                        child: const Text("取消"),
                      ),
                    ),
                  ],
                ),
                Container(
                    child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
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
                    ),
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
                  ],
                )).paddingOnly(left: 18.0, right: 18.0, top: 6.0, bottom: 22.0),
              ]),
        ));
  }
}
