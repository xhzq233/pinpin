import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/page/home/main/home_sliver_header.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';
import 'package:pinpin/page/search/search_hint/search_hint_page.dart';
import 'package:pinpin/page/search/search_result/search_result_page.dart';
import 'package:util/util.dart';

import '../../app/assets/name.dart';
import '../../component/search_bar/search_bar.dart';
import '../../component/stateful_button/pp_image_button.dart';
import 'controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = Get.find<PPSearchController>();
  late TextEditingController _controller;
  late FocusNode _searchNode;

  @override
  void initState() {
    _controller = TextEditingController();
    _searchNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(243, 243, 243, 0.3),
                  Color(0xFFF3F3F3),
                ],
              ),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildSearchInput(),
              Expanded(child: GestureDetector(onTap: _hideKeyboard, child: Obx(() => _buildSearchPageContent())))
            ])),
      ),
    );
  }

  void _hideKeyboard() {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  Widget _buildSearchPageContent() {
    switch (controller.status.value) {
      case Status.hint:
        return const SearchHintPage();
      case Status.result:
        return const SearchResultPage();
      case Status.initial:
      default:
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("历史搜索", style: AppTheme.headline5.copyWith(color: AppTheme.gray20)),
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
            const Wrap(spacing: 8.0, runSpacing: 4.0, alignment: WrapAlignment.start, children: <Widget>[
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
                label: Text('大计赛'),
              ),
              Chip(
                label: Text('美赛'),
              ),
              Chip(
                label: Text('大计赛'),
              ),
            ]),
          ],
        );
    }
  }

  Widget _buildSearchInput() {
    return SizedBox(
      height: PinPinHomeSliverHeaderDelegate.searchBarMinHeight + 5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Hero(tag: PPHomeSearchBar.heroTag, child: _buildSearchBar()),
          ),
          Expanded(
            child: Center(
              child: HoldActiveButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _controller.clear();
                    _hideSoftKeyboard();
                    controller.setStatus(Status.initial);
                  } else {
                    Get.back();
                  }
                },
                builder: (_) => Text(
                  "取消",
                  style: AppTheme.headline5.copyWith(color: AppTheme.gray50),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [AppTheme.shadow],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _buildTextField()),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: FractionallySizedBox(
              heightFactor: 0.76,
              child: PPImageButton(
                active: AppAssets.search,
                size: null,
                padding: 3.2,
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Material(
        color: Colors.transparent,
        child: TextField(
            textInputAction: TextInputAction.search,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            autofocus: false,
            focusNode: _searchNode,
            controller: _controller,
            style: AppTheme.headline5,
            maxLines: 1,
            onChanged: (value) {
              if (value != "") {
                controller.handleSearchPinPin(value);
              } else {
                controller.setStatus(Status.initial);
              }
              setState(() {});
            },
            onSubmitted: (value) {
              controller.handleSearchPinPin(value);
              controller.setStatus(Status.result);
            },
            decoration: InputDecoration(
                isDense: true,
                hintText: "请输入内容...",
                hintStyle: AppTheme.headline5.copyWith(color: AppTheme.gray50),
                border: InputBorder.none,
                suffixIcon: _controller.text != ""
                    ? GestureDetector(
                        onTap: () {
                          _hideSoftKeyboard();
                          _controller.clear();
                          controller.setStatus(Status.initial);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Image.asset(
                            "assets/clear_text.png",
                            width: 16,
                            height: 16,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : const SizedBox.shrink())),
      ),
    );
  }

  void _hideSoftKeyboard() {
    FocusScope.of(context).unfocus();
  }
}
