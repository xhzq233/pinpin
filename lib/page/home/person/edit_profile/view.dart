
import 'dart:io';
import 'package:util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
import 'package:pinpin/component/slide/pp_slide.dart';
import 'package:pinpin/component/stateful_button/hold_active_button.dart';

import 'package:pinpin/page/home/person/controller.dart';

import 'controller.dart';

extension _Bg on Widget {
  Widget _bg() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: this,
        ).background(const DecoratedBox(
          decoration: BoxDecoration(
            color: AppTheme.gray100,
            boxShadow: [AppTheme.shadow],
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        )),
      );
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfilePage> {
  final controller = Get.find<EditProfileController>();
  final personController = Get.find<PPHomePersonController>();

  final back = Image.asset(
    AppAssets.arrow_right,
    height: 45,
    fit: BoxFit.fitHeight,
  );

  Widget getItem(String title, void Function() function) {
    return HoldActiveButton(
      onPressed: function,
      builder: (_) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTheme.headline5,
            ),
            back
          ],
        ).paddingSymmetric(vertical: 3);
      },
    );
  }

  Widget getItemWidthOpenButton(String title, void Function() function) {
    return HoldActiveButton(
      onPressed: function,
      builder: (_) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTheme.headline5,
            ),
            const PPSlide(path: AppAssets.profile)
          ],
        ).paddingSymmetric(vertical: 8);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Object buildImage() => controller.count != 0
        ? FileImage(controller.imageFile.value)
        : const AssetImage(AppAssets.home);

    final avatar = CircleAvatar(
      backgroundImage: buildImage() as ImageProvider,
      radius: 20,
    );

    Widget getItemWidthAvatar(String title, void Function() function) {
      return HoldActiveButton(
          onPressed: function,
          builder: (_) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTheme.headline5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => CircleAvatar(
                        // FileImage(controller.imageFile.value)
                      // FileImage(File(personController.userInfo.value.image))
                      //   NetworkImage(personController.userInfo.value.image)
                        backgroundImage: FileImage(File(personController.userInfo.value.image)),
                        radius: 20)),
                    back
                  ],
                )
              ],
            ).paddingSymmetric(vertical: 3);
          });
    }

    void changeAvatar() {
      controller.onChangeAvatar(context);
      print(personController.userInfo.value.image);
    }

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const PPNavigationBar(title: "编辑个人资料"),
          getItemWidthAvatar("头像", changeAvatar)
              ._bg(),
          getItem("昵称", controller.toEditUsernamePage)._bg(),
          getItem("个人简介", controller.toEditPersonalProfilePage)._bg(),
          getItem("标签页", controller.toEditLabelsPage)._bg(),
          getItemWidthOpenButton(
                  "向他人展示我发布过的", controller.onClickShowOrNotButton)
              ._bg(),
        ],
      ).paddingSymmetric(
        // ListView添加内边距
        horizontal: 16,
      ),
    );
  }
}
