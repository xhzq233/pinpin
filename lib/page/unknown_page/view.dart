/// pinpin - view
/// Created by xhz on 2022/8/9
import 'package:flutter/material.dart';
class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: FittedBox(
            child: Text('not found'),
          ),
        ),
      ),
    );
  }
}
