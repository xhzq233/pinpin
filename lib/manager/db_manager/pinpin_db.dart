/// pinpin - pinpin_db 
/// Created by xhz on 2022/7/28
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class PPDBManager extends GetxService {
  late final Database _database;
  static const _databaseName = 'pinpin.db';
  static const _pinpinTableName = 'pinpin';

  Future<void> createTables(Database db, int version) async {
    // return db.execute(
    //   '''
    //       CREATE TABLE $_pinpinTableName
    //       (
    //         id INTEGER NOT NULL
    //           CONSTRAINT ${_pinpinTableName}_pk
    //             PRIMARY KEY AUTOINCREMENT,
    //         pinpin_id INTEGER NOT NULL,
    //       );
    //       CREATE UNIQUE INDEX ${_pinpinTableName}_pinpin_id_uindex ON $_pinpinTableName (pinpin_id);
    //       ''',
    // );
  }

  Future<PPDBManager> init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: createTables,
      version: 1,
    );
    return this;
  }
}