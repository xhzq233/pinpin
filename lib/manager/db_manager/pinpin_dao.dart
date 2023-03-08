import '../../model/pinpin/pin_pin.dart';
import 'pinpin_db.dart';
import 'package:sqflite/sqflite.dart';

class PinPinDao {

  static Future<void> addPinPin(PinPin pinpin) async {
    await ppDB.insert(pinpinTableName, pinpin.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<PinPin?> getPinPinById(String pinpinId) async {
    List<Map> maps = await ppDB.query(
      pinpinTableName,
      where: 'pinpin_id = ?',
      whereArgs: [pinpinId],
    );
    if (maps.isEmpty) {
      return null;
    }
    return PinPin.fromJson(maps[0]);
  }

  static Future<void> updatePinPin(String pinpinId, PinPin pinpin) async {
    await ppDB.rawUpdate("UPDATE $pinpinTableName SET deadline = ?, title = ?, type = ?, label = ?, description = ?, is_deleted = ?, is_followed = ?, demanding_description = ?, demanding_num = ?, now_num = ?, reply_num = ?, team_introduction = ? where pinpin_id = ?",
        [pinpin.deadline, pinpin.title, pinpin.type, pinpin.label, pinpin.description,
          pinpin.isDeleted, pinpin.isFollowed, pinpin.demandingDescription, pinpin.demandingNum,
          pinpin.nowNum, pinpin.replyNum, pinpin.teamIntroduction, pinpinId]);
  }

  static Future<void> deletePinPin(String pinpinId, bool isDeleted) async {
    await ppDB.rawUpdate("UPDATE $pinpinTableName SET is_delete = ? where pinpin_id = ?",
        [isDeleted, pinpinId]);
  }

  static Future<void> followPinPin(String pinpinId, bool isFollowed) async {
    await ppDB.rawUpdate("UPDATE $pinpinTableName SET is_followed = ? where pinpin_id = ?",
        [isFollowed, pinpinId]);
  }

  static Future<void> updateDescription(String pinpinId, String description) async {
    await ppDB.rawUpdate("UPDATE $pinpinTableName SET description = ? where pinpin_id = ?",
        [description, pinpinId]);
  }

  static Future<void> updateDeadline(String pinpinId, String deadline) async {
    await ppDB.rawUpdate("UPDATE $pinpinTableName SET deadline = ? where pinpin_id = ?",
        [deadline, pinpinId]);
  }

  static Future<void> updateTitle(String pinpinId, String title) async {
    await ppDB.rawUpdate("UPDATE $pinpinTableName SET title = ? where pinpin_id = ?",
        [title, pinpinId]);
  }

  static Future<List<PinPin>> list() async {
    List<Map> maps = await ppDB.query(pinpinTableName);

    List<PinPin> pinpins = [];
    for (var map in maps) {
      pinpins.add(PinPin.fromJson(map));
    }
    return pinpins;
  }
}