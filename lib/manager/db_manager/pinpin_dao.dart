import 'package:pinpin/manager/db_manager/basic_dao.dart';
import '../../model/pinpin/pin_pin.dart';
// import 'package:util/time_converter.dart';
// import '../../model/pinpin/pinpin_list_data.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:floor/floor.dart';


@dao
abstract class PinPinDao with BasicDao<PinPin> {

  // 用于解决更新问题：假设从网络fetch到的list里包含有储存在数据库了的旧数据（因为数据更新了），这时需要replace
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> replacePinPinList(List<PinPin> pinpinList);

  @Query('SELECT * FROM PinPin WHERE pinpinId = :pinpinId')
  Future<PinPin?> getPinPinById(int pinpinId);

  @Query('SELECT * FROM PinPin WHERE type = :type AND label = :label AND :startTime > updatedAt SORT BY updatedAt desc LIMIT 15')
  Future<List<PinPin>?> getPinPinList(int type, int label, int startTime);

  @Query('SELECT * FROM PinPin WHERE ownerEmail = :email')
  Future<List<PinPin>?> getHistoryPinPin(String email);
}

// class PinPinDao1 {
//   static Future<void> addPinPin(PinPin pinpin) async {
//     await ppDB.insert(pinpinTableName, pinpin.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   static Future<void> addPinPinList(List<PinPin>? pinpinList) async {
//     if (null == pinpinList) {
//       return;
//     }
//     for (var pinpin in pinpinList) {
//       addPinPin(pinpin);
//     }
//   }
//
//   static Future<PinPin?> getPinPinById(int pinPinId) async {
//     List<Map> maps = await ppDB.query(
//       pinpinTableName,
//       where: 'pinpin_id = ?',
//       whereArgs: [pinPinId],
//     );
//     if (maps.isEmpty) {
//       return null;
//     }
//     return PinPin.fromJson(maps[0]);
//   }
//
//   static Future<void> updatePinPin(int pinPinId, String title, int label, int type, String deadline,
//       String? description, int demandingNum, int nowNum, String? demandingDescription, String? teamIntroduction) async {
//     await ppDB.rawUpdate(
//         "UPDATE $pinpinTableName SET deadline = ?, title = ?, type = ?, label = ?, description = ?, demanding_description = ?, demanding_num = ?, now_num = ?, team_introduction = ? where pinpin_id = ?",
//         [
//           deadline,
//           title,
//           type,
//           label,
//           description,
//           demandingDescription,
//           demandingNum,
//           nowNum,
//           teamIntroduction,
//           pinPinId
//         ]);
//   }
//
//   static Future<void> updatePinpinPersonQty(int pinPinId, int demandingNum, int nowNum) async {
//     await ppDB.rawUpdate("UPDATE $pinpinTableName SET demanding_num = ?, now_num = ? where pinpin_id = ?",
//         [demandingNum, nowNum, pinPinId]);
//   }
//
//   static Future<void> deletePinPin(int pinPinId) async {
//     await ppDB.rawUpdate("UPDATE $pinpinTableName SET is_delete = 1 where pinpin_id = ?", [pinPinId]);
//   }
//
//   static Future<void> followPinPin(int pinPinId) async {
//     await ppDB.rawUpdate("UPDATE $pinpinTableName SET is_followed = 1 where pinpin_id = ?", [pinPinId]);
//   }
//
//   static Future<void> updateDescription(int pinPinId, String description) async {
//     await ppDB.rawUpdate("UPDATE $pinpinTableName SET description = ? where pinpin_id = ?", [description, pinPinId]);
//   }
//
//   static Future<void> updateDeadline(int pinPinId, String deadline) async {
//     await ppDB.rawUpdate("UPDATE $pinpinTableName SET deadline = ? where pinpin_id = ?", [deadline, pinPinId]);
//   }
//
//   static Future<void> updateTitle(int pinPinId, String title) async {
//     await ppDB.rawUpdate("UPDATE $pinpinTableName SET title = ? where pinpin_id = ?", [title, pinPinId]);
//   }
//
//   static Future<PinPinListData?> getPinPinList(int type, int label, int startTime) async {
//     List<Map> maps = await ppDB.query(pinpinTableName);
//     List<PinPin> pinpins = [];
//     for (var map in maps) {
//       if (DateTime.parse(map['update_time'])
//                   .difference(DateTime.fromMillisecondsSinceEpoch(startTime * 1000))
//                   .inMinutes <
//               10 &&
//           map['is_deleted'] != 1) {
//         pinpins.add(PinPin.fromJson(map));
//       }
//     }
//     if (pinpins.isEmpty) {
//       return null;
//     }
//     pinpins.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
//     if (pinpins.length > 15) {
//       pinpins = pinpins.sublist(0, 15);
//     }
//     PinPinListData pinPinListData = PinPinListData(data: pinpins, latestTime: DateTime.now().millisecondsSinceEpoch);
//     return pinPinListData;
//   }
// }
