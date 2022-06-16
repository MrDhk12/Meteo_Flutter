import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:meteo/models/city_citydb.dart';

class SqliteService {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Cities(id INTEGER PRIMARY KEY AUTOINCREMENT, city TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<bool> inertData(CityModel cityModel) async {
    final Database db = await initDB();
    db.insert("Cities", cityModel.toMap());
    return true;
  }

  Future<List<CityModel>> getData() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> datas = await db.query("Cities");
    return datas.map((e) => CityModel.fromMap(e)).toList();
  }

  Future<void> update(CityModel cityModel, int id) async {
    final Database db = await initDB();
    await db
        .update("Cities", cityModel.toMap(), where: "id=?", whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    final Database db = await initDB();
    try {
      await db.delete("Cities", where: "id=?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // void createTable(Database db) async {
  //   db?.execute(
  //       "CREATE TABLE Cities(id INTEGER PRIMARY KEY AUTOINCREMENT, city TEXT NOT NULL)");
  // }

  Future<void> getCities(String city) async {
    final Database db = await initDB();
    await db.query("Cities", where: "city=?", whereArgs: [city]);
  }
}
