import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/manager/api/http_client.dart';
import 'logic.dart';

class LoginPage extends GetView<LoginLogic> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World!');
  }
}