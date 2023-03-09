import '../../model/user_info/user_info.dart';
import 'pinpin_db.dart';
import 'package:sqflite/sqflite.dart';

class UserInfoDao {

  static Future<void> addUserInfo(UserInfo? userInfo) async {
    if (null == userInfo) {
      return;
    }
    await ppDB.insert(userInfoTableName, userInfo.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<UserInfo?> getUserInfoByEmail(String email) async {
    List<Map> maps = await ppDB.query(
      userInfoTableName,
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isEmpty) {
      return null;
    }
    return UserInfo.fromJson(maps[0]);
  }

  static Future<void> updateUserInfo(String email, UserInfo userInfo) async {
    await ppDB.rawUpdate("UPDATE $userInfoTableName SET background = ?, image = ?, user_name = ?, brief = ?, my_tags = ?, where email = ?",
        [userInfo.background, userInfo.image, userInfo.username, userInfo.brief, userInfo.myTags, email]);
  }

  static Future<void> updateUserName(String email, String userName) async {
    await ppDB.rawUpdate("UPDATE $userInfoTableName SET user_name = ? where email = ?", [userName, email]);
  }

  static Future<void> updateBrief(String email, String brief) async {
    await ppDB.rawUpdate("UPDATE $userInfoTableName SET brief = ? where email = ?", [brief, email]);
  }

  static Future<void> updateImage(String email, String image) async {
    await ppDB.rawUpdate("UPDATE $userInfoTableName SET image = ? where email = ?", [image, email]);
  }

  static Future<void> updateMyTags(String email, String myTags) async {
    await ppDB.rawUpdate("UPDATE $userInfoTableName SET my_tags = ? where email = ?", [myTags, email]);
  }

  static Future<List<UserInfo>> list() async {
    List<Map> maps = await ppDB.query(userInfoTableName);

    List<UserInfo> userInfos = [];
    for (var map in maps) {
      userInfos.add(UserInfo.fromJson(map));
    }
    return userInfos;
  }
}