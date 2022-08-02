/// pinpin - account_manager
/// Created by xhz on 27/07/2022

import 'dart:convert';

import 'package:get/get.dart';
import 'package:pinpin/model/user_info/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AccountManager extends GetxService {
  static const _dataKeyName = "accounts";
  static const _dataIndexKeyName = "account_index";

  final Rx<List<UserInfo>> accounts = Rx([]);

  late final SharedPreferences _sharedPreferences;

  late final RxInt currentIndex;

  Future<AccountManager> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final tempAccounts = _sharedPreferences.getStringList(_dataKeyName);
    if (null != tempAccounts) {
      accounts().addAll(
        tempAccounts.map(
              (jsonString) {
            final json = jsonDecode(jsonString);
            return UserInfo.fromJson(json);
          },
        ),
      );
    }
    currentIndex = RxInt(_sharedPreferences.getInt(_dataIndexKeyName) ?? (accounts().isNotEmpty ? 0 : -1));
    return this;
  }

  ///保存账号
  void saveAccounts() {
    _sharedPreferences.setStringList(_dataKeyName, accounts().map((account) => jsonEncode(account.toJson())).toList());
  }

  void setMainAccount(int index) async {
    currentIndex.value = index;
    _sharedPreferences.setInt(_dataIndexKeyName, index);
  }

  ///更新账号
  void updateAccount(UserInfo account) {
    accounts.update((val) {
      if (null != val) {
        for (int i = 0; i < val.length; i++) {
          if (account.id == val[i].id) {
            val[i] = account;
            saveAccounts();
            break;
          }
        }
      }
    });
  }

  ///添加账号
  void addAccount(UserInfo account) {
    //如果已经存在就更新
    if (accounts().any((element) => element.id == account.id)) {
      updateAccount(account);
    } else {
      accounts.update((val) {
        val?.add(account);
      });
      if (1 == accounts().length) {
        setMainAccount(0);
      } else {
        setMainAccount(accounts().length - 1);
      }
      saveAccounts();
    }
  }

  ///移除账号
  void removeAccount(UserInfo account) {
    accounts.update((val) {
      val?.removeWhere((element) => element.id == account.id);
    });
    saveAccounts();
  }

  ///移除账号
  void removeAccountAt(int index) {
    accounts.update((val) {
      val?.removeAt(index);
    });
    saveAccounts();
  }

  UserInfo? get current {
    if (-1 == currentIndex.value) {
      return null;
    }
    return accounts()[currentIndex.value];
  }

  bool get isEmpty => accounts().isEmpty;

  bool get isNotEmpty => accounts().isNotEmpty;
}