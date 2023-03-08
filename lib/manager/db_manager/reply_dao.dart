import '../../model/reply/reply.dart';
import 'pinpin_db.dart';
import 'package:sqflite/sqflite.dart';

class ReplyDao {

  static Future<void> addAccount(Reply reply) async {
    await ppDB.insert(replyTableName, reply.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<Reply?> getReplyByEmail(String email) async {
    final maps = await ppDB.query(
      replyTableName,
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isEmpty) {
      return null;
    }
    return Reply.fromJson(maps[0]);
  }

  static Future<void> updateUserName(String email, String userName) async {
    await ppDB.rawUpdate("UPDATE $replyTableName SET user_name = ? where email = ?", [userName, email]);
  }

  static Future<List<Reply>> list() async {
    final maps = await ppDB.query(replyTableName);

    List<Reply> replies = [];
    for (var map in maps) {
      replies.add(Reply.fromJson(map));
    }
    return replies;
  }
}