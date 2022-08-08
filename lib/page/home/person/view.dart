/// pinpin - view
/// Created by xhz on 07/08/2022

import 'package:flutter/material.dart';
import 'package:pinpin/component/widget_extensions/ext.dart';
import 'package:pinpin/page/home/person/controller.dart';
import 'package:get/get.dart';

class PPHomePersonView extends GetView<PPHomePersonController> {
  const PPHomePersonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World').centralized();
  }
}
