/// pinpin - view
/// Created by xhz on 2022/8/9
import 'package:flutter/material.dart';
import 'package:pinpin/component/header/navigation_bar.dart';

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PPNavigationBar(title: "Not Found",),
      body:  Center(
        child: FractionallySizedBox(
          heightFactor: 0.4,
          widthFactor: 0.4,
          child: FittedBox(
            child: Text(
              'not found',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
