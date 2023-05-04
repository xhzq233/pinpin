import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PPBottomSheet extends StatefulWidget {
  final BuildContext context;
  final List<String> options;
  final void Function(dynamic) onFirstTap;
  final void Function(dynamic) onSecondTap;

  const PPBottomSheet({Key? key, required this.context, required this.options, required this.onFirstTap, required this.onSecondTap}) : super(key: key);

  @override
  State<PPBottomSheet> createState() => _PPBottomSheetState();
}

class _PPBottomSheetState extends State<PPBottomSheet> {

  @override
  Widget build(BuildContext context) {

    return Container(
      clipBehavior: Clip.antiAlias, // clip是什么？
      decoration: const BoxDecoration( // 修饰颜色和边角
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),// 上面两个边角
          topRight: Radius.circular(20.0),
        ),
      ),
      height: MediaQuery.of(context).size.height / 3.0,
      child: Column(children: [ // Column添加组件
        SizedBox( // 最上面的弹窗主题部分
          height: 50,
          child: Stack(
            textDirection: TextDirection.rtl,
            children: [
              const Center(
                child: Text(
                  '底部弹窗',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
        const Divider(height: 1.0), // 分割线
        Expanded(
          child: ListView.builder( // ListView
            itemBuilder: (BuildContext context, int index) {
              return ListTile(// ListTile作为item
                  title: Text(widget.options[index]),
                  onTap: () async{
                    index == 1
                        ? widget.onFirstTap(await ImagePicker().pickImage(source: ImageSource.camera))
                        : widget.onSecondTap(await ImagePicker().pickImage(source: ImageSource.gallery));
                  });
            },
            itemCount: widget.options.length,
          ),
        ),
      ]),
    );
  }
}
