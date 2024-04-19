import 'package:flutter/cupertino.dart';
import 'package:util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinpin/app/assets/name.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/component/header/navigation_bar.dart';
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


  Widget getItemWithUsername(String title, void Function() function) {
    return HoldActiveButton(
      onPressed: function,
      builder: (_) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              title,
              style: AppTheme.headline5,
            ),
            const Spacer(),
            Text(
              controller.userInfo?.username ?? "",
              style: AppTheme.headline5,
            ),
            back
          ],
        ).paddingSymmetric(vertical: 3);
      },
    );
  }

  Widget getItemWidthOpenButton(
      {required String title,
      void Function()? onTap,
      void Function(bool)? onChanged}) {
    return HoldActiveButton(
      onPressed: onTap,
      builder: (_) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTheme.headline5,
            ),
            Obx(() => CupertinoSwitch(
                  value: controller.switchValue.value,
                  onChanged: onChanged,
                  activeColor: const Color(0xFF0076FC),
                  trackColor: const Color(0xFFBAC8D9),
                  thumbColor: const Color(0xFFFFFFFF),
                ))
          ],
        ).paddingSymmetric(vertical: 8);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        backgroundImage: FileImage(controller.imageFile.value),
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
    }

    return Scaffold(
      appBar: const PPNavigationBar(
          title: "编辑个人资料",
          background: Color(0xFF0076FC),
          whiteAccent: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top),
                  getItemWidthAvatar("头像", changeAvatar)._bg(),
                  getItemWithUsername("昵称", controller.toEditUsernamePage)._bg(),
                  getItem("个人简介", controller.toEditPersonalProfilePage)._bg(),
                  getItem("标签页", controller.toEditLabelsPage)._bg(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: getItemWidthOpenButton(
                  title: "向他人展示我发布过的",
                  onTap: controller.onClickShowOrNotButton,
                  onChanged: (value) {
                    controller.onClickShowOrNotButton();
                  })
                  ._bg(),
            ),
          ]
        ).paddingSymmetric(
          horizontal: 16,
        ),
      ),
    );
  }
}
