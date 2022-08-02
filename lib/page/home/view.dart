import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  int index = 0;
  final source = PinPinLoadMoreSource();
  late final tabPages = [
    RefreshableSliverList(
      sliverHeader: SliverAppBar(
        floating: true,
        snap: true,
        pinned: true,
        expandedHeight: 120,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(I18n.title.tr),
          background: Image.network(
            'https://xhzq.xyz/images/doge.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      sourceList: source,
      itemBuilder: (BuildContext context, PinPin item, int index) => Text(
        item.title,
        style: Get.textTheme.headline2,
      ),
    ),
    const Text('data').centralized(),
  ];

  @override
  Widget build(BuildContext context) {
    CupertinoTabScaffold;
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: tabPages,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                index == 0 ? 'assets/edit.png' : 'assets/cancel.png',
                height: 50,
              ).onTap(() {
                setState(() => index = 0);
              }),
            ),
            Expanded(
              child: Image.asset(
                index == 1 ? 'assets/edit.png' : 'assets/cancel.png',
                height: 50,
              ).onTap(() {
                setState(() => index = 1);
              }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
