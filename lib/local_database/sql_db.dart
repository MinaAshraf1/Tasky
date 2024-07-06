import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if(_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'ToDoDatabase.db');
    Database myDB = await openDatabase(path, onCreate: _onCreate, version: 2);
    return myDB;
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute(
      '''
        CREATE TABLE "TODO" (
           "id" INTEGER PRIMARY KEY AUTOINCREMENT,
           "title" TEXT NOT NULL,
           "description" TEXT,
           "important" String DEFAULT "regular",
           "complete" INTEGER DEFAULT 0,
           "due_date" TEXT DEFAULT CURRENT_TIMESTAMP
        )
      '''
    );

    await batch.commit();
  }

  getData(String sql) async {
    Database? myDB = await db;
    List<Map> response = await myDB!.rawQuery(sql);
    return response;
  }

  getData2(String where, List whereArgs) async {
    Database? myDB = await db;
    List<Map> response = await myDB!.query(
      'TODO',
      where: where,
      whereArgs: whereArgs
    );
    return response;
  }

  addData(String sql) async {
    Database? myDB = await db;
    int response = await myDB!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDB = await db;
    int response = await myDB!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDB = await db;
    int response = await myDB!.rawDelete(sql);
    return response;
  }

  readData(String table) async {
    Database? myDB = await db;
    List<Map> response = await myDB!.query(table);
    return response;
  }

}