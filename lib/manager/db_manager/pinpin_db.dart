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
            team_introduction VARCHAR(200) DEFAULT 'No demanding description',
            demanding_description VARCHAR(200) DEFAULT 'No team introduction',
            demanding_num INTEGER NOT NULL,
            is_followed BOOLEAN DEFAULT false,
            is_deleted BOOLEAN DEFAULT false,
            now_num INTEGER NOT NULL,
            reply_num INTEGER DEFAULT 0,
            owner_email VARCHAR(32) NOT NULL,
            updated_at INTEGER NOT NULL,
            create_at INTEGER DEFAULT 0,
            description VARCHAR(1037) NOT NULL,
          );
          CREATE UNIQUE INDEX ${pinpinTableName}_pinpin_id_uindex ON $pinpinTableName (pinpin_id);
        ''',
    );

    await db.execute(
        '''
          CREATE TABLE $accountTableName
          (
            id INTEGER NOT NULL
              CONSTRAINT ${accountTableName}_pk
                PRIMARY KEY AUTOINCREMENT,
            user_name VARCHAR(32) NOT NULL,
            token VARCHAR(104) NOT NULL,
            email VARCHAR(32) NOT NULL,
            image VARCHAR(104) NOT NULL,
          );
          CREATE UNIQUE INDEX ${accountTableName}_email_uindex ON $accountTableName (email);
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
            is_deleted BOOLEAN NOT NULL,
            Is_thumb_up BOOLEAN NOT NULL,
            pinpin_id INTEGER NOT NULL,
            reply_to INTEGER NOT NULL,
            thumb_up_int INTEGER NOT NULL,
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
            background VARCHAR(104) NOT NULL,
            image VARCHAR(104) NOT NULL,
            brief VARCHAR(40) NOT NULL,
            my_tags VARCHAR(32) NOT NULL,
            username VARCHAR(32) NOT NULL,
            email VARCHAR(32) NOT NULL,
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