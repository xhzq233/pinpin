/// pinpin - search_bar
/// 用于首页和搜索页，包含TextField拥有自己的controller、focusNode
/// Created by xhz on 2022/8/4
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/route/route_name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/stateful_button/pp_image_button.dart';
import 'package:util/util.dart';

class PPHomeSearchBar extends StatefulWidget {
  const PPHomeSearchBar({Key? key, this.onClick = defaultOnClick, this.textEditingController}) : super(key: key);
  static const heroTag = 'home_search_bar';

  final void Function() onClick;
  final TextEditingController? textEditingController;

  static void defaultOnClick() {
    Get.toNamed(RN.search);
  }

  @override
  State<PPHomeSearchBar> createState() => _PPHomeSearchBarState();
}

class _PPHomeSearchBarState extends State<PPHomeSearchBar> {
  late TextEditingController _controller;
  late FocusNode _searchNode;

  @override
  void initState() {
    _controller = widget.textEditingController ?? TextEditingController();
    _searchNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchNode.dispose();
    super.dispose();
  }

  Widget _buildSearchInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Material(
        color: Colors.transparent,
        child: TextField(
            focusNode: _searchNode,
            controller: _controller,
            style: AppTheme.headline5,
            maxLines: 1,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
                hintText: "请输入内容...",
                hintStyle: AppTheme.headline5.copyWith(color: AppTheme.gray50),
                border: InputBorder.none,
                suffixIcon: _controller.text != ""
                    ? GestureDetector(
                        onTap: () {
                          _hideSoftKeyboard();
                          _controller.clear();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
        boxShadow: [AppTheme.shadow],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _buildSearchInput()),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: FractionallySizedBox(
              heightFactor: 0.76,
              child: PPImageButton(
                active: AppAssets.search,
                size: null,
                padding: 3.2,
                onPressed: widget.onClick,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _hideSoftKeyboard() {
    FocusScope.of(context).unfocus();
  }
}
