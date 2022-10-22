import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/bottom_tab_bar/bottom_tab_bar.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/page/home/main/controller.dart';
import 'package:pinpin/page/home/main/home_main.dart';
import 'package:pinpin/page/home/person/controller.dart';
import 'package:pinpin/page/home/person/home_person.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabBarIndex = 0;

  @override
  void initState() {
    super.initState();
    Get.put(PPHomeMainController());
    Get.put(PPHomePersonController());
  }

  static const active_items = [
    AppAssets.home_active,
    AppAssets.person_active,
  ];
  static const items = [
    AppAssets.home,
    AppAssets.person,
  ];
  static const titles = ['Home', 'Person'];

  Widget _buildTabItem(int index) => HoldActiveButton(
        onPressed: () => setState(() => tabBarIndex = index),
        builder: (_) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 3.5),
              child: Image.asset(
                tabBarIndex == index ? active_items[index] : items[index],
                height: 30,
              ),
            ),
            Text(titles[index]),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final bottomBar = PPBottomTabBar(
      children: [
        _buildTabItem(0),
        HoldActiveButton(
            onPressed: () => Get.toNamed(RN.post),
            builder: (_) => const DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.blueAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x5882B1FF),
                        spreadRadius: 6,
                        blurRadius: 10,
                        offset: Offset(1, 5),
                      )
                    ],
                  ),
                  child: FittedBox(
                    child: Icon(Icons.add, color: AppTheme.gray100),
                  ),
                ).sized(height: 50, width: 54).paddingOnly(top: 5)),
        _buildTabItem(1),
      ],
    );

    return Scaffold(
      body: IndexedStack(
        index: tabBarIndex,
        children: const [
          PPHomeMainView(),
          PPHomePersonView(),
        ],
      ).overlay(Align(
        alignment: Alignment.bottomCenter,
        child: bottomBar,
      )),
    );
  }
}
