/// pinpin - login_base_page
/// Created by xhz on 08/09/2022
import 'package:flutter/material.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/text_field/pp_text_field.dart';
import 'package:pinpin/component/text_field/unfocus.dart';

class BaseLoginPage extends StatelessWidget {
  const BaseLoginPage({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PPNavigationBar(),
      body: AutoUnFocusWrap(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: body,
        ),
      ),
    );
  }
}
