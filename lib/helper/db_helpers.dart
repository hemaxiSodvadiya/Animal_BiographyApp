import 'dart:typed_data';

import 'package:animal_app/helper/splash_api.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/global_data.dart';
import '../model/model.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();
  Database? db;
  final String dbName = "animalsData.db";
  final String colId = "id";
  final String colTime = "time";
  final String colPrice = "price";
  final String colImage = "image";
  final String colName = "name";
  final String colDescription = "description";
  final String colCategory = "category";

  Future<void> initDB({required String tableName}) async {
    String direcotory = await getDatabasesPath();
    String path = join(direcotory, tableName);

    db = await openDatabase(path, version: 1, onCreate: (db, version) {});
    await db?.execute(
        "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTime TEXT, $colPrice Text,$colImage BLOB)");
  }

  insertRecord(
      {required String tableName, required List<AnimalData> data}) async {
    await initDB(tableName: tableName);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < data.length; i++) {
      Uint8List? image =
          await ImageApi.imageApi.getImage(search: "${i + 1} wild animal");

      String query =
          "INSERT INTO $tableName($colTime, $colPrice, $colImage) VALUES(?,?,?)";

      List args = [data[i].time, data[i].price, image];
      await db?.rawInsert(query, args);
    }
    prefs.setBool(tableName, true);
  }

  Future<void> updateImage(
      {required String tableName, required int length}) async {
    for (int i = 0; i < length; i++) {
      Uint8List? image =
          await ImageApi.imageApi.getImage(search: "${i + 1} wildAnimal");
      String query =
          "UPDATE $tableName SET $colImage = ? WHERE $colId = ${i + 1}";
      List args = [image];
      await db?.rawUpdate(query, args);
    }
  }

  Future<List<DBData>> fetchAllRecord(
      {required String tableName, required List<AnimalData> data}) async {
    await initDB(tableName: tableName);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isInserted = prefs.getBool(tableName) ?? false;
    (isInserted)
        ? await updateImage(tableName: tableName, length: data.length)
        : await insertRecord(tableName: tableName, data: data);
    String query = "SELECT * FROM $tableName";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<DBData> animalList = res.map((e) => DBData.fromData(e)).toList();
    return animalList;
  }

  insertAnimalData(
      {required String tableName, required List<Animal> data}) async {
    await db?.execute(
        "CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colDescription TEXT, $colImage BLOB, $colCategory TEXT)");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isInserted = prefs.getBool(tableName) ?? false;
    if (isInserted == false) {
      for (int i = 0; i < data.length; i++) {
        Uint8List image =
            (await rootBundle.load("assets/images/${data[i].name}.jpg"))
                .buffer
                .asUint8List();
        String query =
            "INSERT INTO $tableName($colName, $colDescription,$colImage,$colCategory) VALUES(?, ?,?,?)";
        List args = [
          data[i].name,
          data[i].description,
          image,
          data[i].category,
        ];

        await db?.rawInsert(query, args);
      }
      prefs.setBool(tableName, true);
    }
  }

  Future<List<DBAnimal>> fetchAllAnimalData(
      {required String tableName, required List<Animal> data}) async {
    await insertAnimalData(tableName: tableName, data: data);

    String query = (Global.category == "")
        ? "SELECT * FROM $tableName"
        : "SELECT * FROM $tableName WHERE $colCategory LIKE '%${Global.category}%'";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<DBAnimal> animalsList = res.map((e) => DBAnimal.fromData(e)).toList();

    return animalsList;
  }
}
