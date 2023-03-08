import 'pinpin_db.dart';
import 'package:pinpin/model/account/account.dart';
import 'package:sqflite/sqflite.dart';

class AccountDao {

  static Future<void> addAccount(Account account) async {
    await ppDB.insert(accountTableName, account.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<Account?> getAccountByEmail(String email) async {
    List<Map> maps = await ppDB.query(
      accountTableName,
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isEmpty) {
      return null;
    }
    return Account.fromJson(maps[0]);
  }

  static Future<void> updateUserName(String email, String userName) async {
    await ppDB.rawUpdate("UPDATE $accountTableName SET user_name = ? where email = ?", [userName, email]);
  }

  static Future<List<Account>> list() async {
    List<Map> maps = await ppDB.query(accountTableName);

    List<Account> accounts = [];
    for (var map in maps) {
      accounts.add(Account.fromJson(map));
    }
    return accounts;
  }
}