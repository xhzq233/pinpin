import 'dart:html';

import 'package:pinpin/model/reply/reply_list_data.dart';

import '../../model/reply/reply.dart';
import 'pinpin_db.dart';
import 'package:sqflite/sqflite.dart';

class ReplyDao {

  static Future<void> addReplys(List<Reply>? replys) async {
    if(null == replys) {
      return;
    }
    for (var reply in replys) {
      addReply(reply);
    }
  }

  static Future<void> addReply(Reply reply) async {
    await ppDB.insert(replyTableName, reply.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteReply(int pinPinId, int replyId) async {
    ppDB.rawUpdate("DELETE FROM $replyTableName where pinpin_id = ? and id = ?",
        [pinPinId, replyId]);
  }

  static Future<List<Reply>?> getRepliesByReplyTo(int pinpinId, int replyTo) async {
    final maps = await ppDB.query(
      replyTableName,
      where: 'reply_to = ? and pinpin_id = ?',
      whereArgs: [replyTo, pinpinId]
    );
    if (maps.isEmpty) {
      return null;
    }
    List<Reply> replies = [];
    for (var map in maps) {
      replies.add(Reply.fromJson(map));
    }
    return replies;
  }

  /// ReplyTo 评论给谁 若非0则是回复评论，否则为评论拼拼帖
  static Future<ReplyListData?> getCommentsByPinPinId(int pinpinId) async {
    final maps = await ppDB.query(
        replyTableName,
        where: 'reply_to = 0 and pinpin_id = ?',
        whereArgs: [pinpinId]
    );
    if (maps.isEmpty) {
      return null;
    }
    List<Reply> replies = [];
    for (var map in maps) {
      replies.add(Reply.fromJson(map));
    }
    final replys = ReplyListData(data: replies);
    return replys;
  }

  static Future<void> thumbUpReply(int replyId) async {
    final map = await ppDB.query(
        replyTableName,
        where: 'where id = ?',
        whereArgs: [replyId]
    );
    if (map[0]['is_thumb_up'] == 1) {
      return;
    } else {
      int num = map[0]['thumb_up_int'] as int;
      await ppDB.rawUpdate("UPDATE $replyTableName SET is_thumb_up = 1, thumb_up_int = ? where id = ?",
          [replyId, num+1]);
    }
  }

  static Future<void> removeThumbUpReply(int replyId) async {
    final map = await ppDB.query(
        replyTableName,
        where: 'where id = ?',
        whereArgs: [replyId]
    );
    if (map[0]['is_thumb_up'] == 0) {
      return;
    } else {
      int num = map[0]['thumb_up_int'] as int;
      await ppDB.rawUpdate("UPDATE $replyTableName SET is_thumb_up = 0, thumb_up_int = ? where id = ?",
          [replyId, num-1]);
    }
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