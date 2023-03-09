/// pinpin - pinpin_db 
/// Created by xhz on 2022/7/28
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const databaseName = 'pinpin.db';
const accountTableName = 'account';
const pinpinTableName = 'pinpin';
const noticeTableName = 'notice';
const replyTableName = 'reply';
const responseTableName = 'response';
const userInfoTableName = 'userinfo';

Database get ppDB => Get.find<PPDBManager>().ppDB;

class PPDBManager extends GetxService {
  late final Database ppDB;

  Future<void> createTables(Database db, int version) async {
    await db.execute(
        '''
          CREATE TABLE $pinpinTableName
          (
            id INTEGER NOT NULL
              CONSTRAINT ${pinpinTableName}_pk
                PRIMARY KEY AUTOINCREMENT,
            pinpin_id INTEGER NOT NULL,
            title VARCHAR(32) NOT NULL,
            type INTEGER NOT NULL,
            deadline DATE NOT NULL,
            label INTEGER NOT NULL,
            team_introduction TEXT DEFAULT 'No demanding description',
            demanding_description TEXT DEFAULT 'No team introduction',
            demanding_num INTEGER NOT NULL,
            is_followed INTEGER DEFAULT false,
            is_deleted INTEGER DEFAULT false,
            now_num INTEGER NOT NULL,
            reply_num INTEGER DEFAULT 0,
            owner_email VARCHAR(32) NOT NULL,
            updated_at INTEGER NOT NULL,
            create_at INTEGER DEFAULT 0,
            description TEXT NOT NULL,
            update_time TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT
          );
          CREATE UNIQUE INDEX ${pinpinTableName}_pinpin_id_uindex ON $pinpinTableName (pinpin_id);
        ''',
    );

    await db.execute(
        '''
          CREATE TABLE $noticeTableName
          (
            id INTEGER NOT NULL
              CONSTRAINT ${noticeTableName}_pk
                PRIMARY KEY AUTOINCREMENT,
            created_at VARCHAR(32) NOT NULL,
            updated_at VARCHAR(32) NOT NULL,
            deleted_at VARCHAR(32) NOT NULL,
            title VARCHAR(32) NOT NULL,
            content VARCHAR(400) NOT NULL,
            email VARCHAR(32) NOT NULL,
            time_stamp INTEGER NOT NULL,
            is_read BOOLEAN NOT NULL,
            update_time TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT
          );
        ''',
    );

    await db.execute(
        '''
          CREATE TABLE $replyTableName
          (
            id INTEGER NOT NULL
              CONSTRAINT ${replyTableName}_pk
                PRIMARY KEY AUTOINCREMENT,
            created_at VARCHAR(32) NOT NULL,
            content VARCHAR(204) NOT NULL,
            email VARCHAR(32) NOT NULL,
            is_deleted INTEGER NOT NULL,
            is_thumb_up INTEGER NOT NULL,
            pinpin_id INTEGER NOT NULL,
            reply_to INTEGER NOT NULL,
            thumb_up_int INTEGER NOT NULL,
            update_time TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT
          );
        ''',
    );

    await db.execute(
        '''
          CREATE TABLE $userInfoTableName
          (
            id INTEGER NOT NULL
              CONSTRAINT ${userInfoTableName}_pk
                PRIMARY KEY AUTOINCREMENT,
            background VARCHAR(255) NOT NULL,
            image VARCHAR(255) NOT NULL,
            brief TEXT NOT NULL,
            my_tags VARCHAR(32) NOT NULL,
            username VARCHAR(32) NOT NULL,
            email VARCHAR(32) NOT NULL,
            update_time TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT
          );
          CREATE UNIQUE INDEX ${userInfoTableName}_email_uindex ON $userInfoTableName (email);
        ''',
    );
  }

  Future<PPDBManager> init() async {
    ppDB = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: createTables,
      version: 1,
    );
    return this;
  }

}