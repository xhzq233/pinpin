/// pinpin - account_manager
/// Created by xhz on 27/07/2022

import 'dart:convert';

import 'package:get/get.dart';
import 'package:pinpin/model/account/account.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AccountManager extends GetxService {
  static const _dataKeyName = "accounts";
  static const _dataIndexKeyName = "account_index";

  final Rx<List<Account>> accounts = Rx([]);

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
            return Account.fromJson(json);
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
  void updateAccount(Account account) {
    accounts.update((val) {
      if (null != val) {
        for (int i = 0; i < val.length; i++) {
          if (account.email == val[i].email) {
            val[i] = account;
            break;
          }
        }
      }
    });
  }

  ///添加账号
  void addAccount(Account account) {
    //如果已经存在就更新
    if (accounts().any((element) => element.email == account.email)) {
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
  void removeAccount(Account account) {
    accounts.update((val) {
      val?.removeWhere((element) => element.email == account.email);
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

  Account? get current {
    if (-1 == currentIndex.value) {
      return null;
    }
    return accounts()[currentIndex.value];
  }

  bool get isEmpty => accounts().isEmpty;

  bool get isNotEmpty => accounts().isNotEmpty;
}