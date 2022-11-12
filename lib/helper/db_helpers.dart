import 'package:animal_app/helper/splash_api.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import '../global/global_data.dart';
import '../model/model.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper dbHelper = DbHelper._();

  final String dbName = "animalData.db";
  final String tableName = "data";
  final String colId = "id";
  final String colMonths = "months";
  final String colPrice = "price";
  final String colImage = "image";
  final String colName = "name";
  final String colDescription = "description";
  final String colCategory = "category";

  Database? db;

  Future<Database?> initDB() async {
    String directory = await getDatabasesPath();
    String path = join(directory, dbName);

    db = await openDatabase(path, version: 1, onCreate: (db, version) {});

    await db?.execute(
        "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colMonths TEXT,$colPrice TEXT,$colImage BLOB)");

    return db;
  }

  insertAllRecord({required List<WildAnimal> data}) async {
    await initDB();
    for (int i = 0; i < data.length; i++) {
      Uint8List? image = await SplashHelper.splashHelper.splashImage();

      String query =
          "INSERT INTO $tableName($colMonths,$colPrice,$colImage) VALUES(?,?,?)";
      List args = [data[i].months, data[i].price, image];

      await db?.rawInsert(query, args);
    }
  }

  Future<List<WildAnimal>> fetchAllRespons(
      {required List<WildAnimal> data}) async {
    await initDB();
    await updateRespons(length: data.length);

    String query = "SELECT * FROM $tableName";
    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    List<WildAnimal> animals =
        res.map((e) => WildAnimal.fromJson(jsonData: e)).toList();

    return animals;
  }

  Future<void> updateRespons({required int length}) async {
    await initDB();
    for (int i = 0; i < length; i++) {
      Uint8List? image = await SplashHelper.splashHelper.splashImage();

      String query =
          "UPDATE $tableName SET $colImage = ? WHERE $colId = ${i + 1}";
      List args = [image];
      await db?.rawUpdate(query, args);
    }
  }

  insertAnimalData({required List<WildAnimal> data}) async {
    await initDB();
    await db?.execute(
        "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT,$colDescription TEXT,$colImage BLOB,$colCategory TEXT)");

    for (int i = 0; i < data.length; i++) {
      Uint8List image =
          (await rootBundle.load("assets/images/${data[i].name}.jpg"))
              .buffer
              .asUint8List();

      String query =
          "INSERT INTO $tableName($colName, $colDescription,$colImage,$colCategory) VALUES(?, ?,?,?)";
      List args = [data[i].name, data[i].description, image, data[i].category];

      await db?.rawInsert(query, args);
    }
  }

  Future<List<WildAnimal>> fetchAllAnimalData(
      {required List<WildAnimal> data}) async {
    await insertAnimalData(data: data);
    await initDB();
    String query = (Global.category == "")
        ? "SELECT * FROM $tableName"
        : "SELECT * FROM $tableName"
            "WHERE $colCategory LIKE '%${Global.category}%'";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<WildAnimal> animals =
        res.map((e) => WildAnimal.fromJson(jsonData: e)).toList();

    return animals;
  }
}
