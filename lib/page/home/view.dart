import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/component/cupertino/system_blur_effect.dart';
import 'package:pinpin/component/header/home_sliver_header.dart';
import 'package:pinpin/component/list_view/refreshable_list.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/app/i18n/i18n_names.dart';
import 'package:pinpin/model/load_more/pinpin.dart';
import 'package:pinpin/model/pinpin/pin_pin.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabBarIndex = 0;
  final source = PinPinLoadMoreSource();
  late final tabPages = [
    RefreshableSliverList(
      sliverHeader: const SliverPersistentHeader(
        pinned: true,
        delegate: PinPinHomeSliverHeaderDelegate(),
      ),
      sourceList: source,
      itemBuilder: (BuildContext context, PinPin item, int index) => Text(
        item.title,
        style: Get.textTheme.headline1,
      )
          .background(const DecoratedBox(
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(50)))))
          .paddingSymmetric(vertical: 20),
    ),
    const Text('data').centralized(),
  ];

  static const active_items = [
    AppAssets.home_active,
    AppAssets.person_active,
  ];
  static const items = [
    AppAssets.home,
    AppAssets.person,
  ];
  static const titles = ['Home', 'Person'];

  Widget _buildTabItem(int index) => Column(
        children: [
          Image.asset(
            tabBarIndex == index ? active_items[index] : items[index],
            height: 30,
          ).paddingOnly(top: 15, bottom: 3.5),
          Text(titles[index]),
        ],
      ).onTap(() {
        setState(() => tabBarIndex = index);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: tabBarIndex,
        children: tabPages,
      ).overlay(
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTabItem(0),
              Container(
                height: 50,
                width: 54,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.blueAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x5882B1FF),
                        spreadRadius: 6,
                        blurRadius: 10,
                        offset: Offset(1, 5),
                      )
                    ]),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ).paddingOnly(top: 5),
              _buildTabItem(1),
            ],
          ).sized(height: 88).cupertinoSystemBlurEffect(),
        ),
      ),
    );
  }
}
