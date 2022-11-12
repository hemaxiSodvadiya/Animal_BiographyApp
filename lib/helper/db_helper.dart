import 'package:animal_app/helper/splash_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/model.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();

  String tableName = "Wild Animal";
  String dbName = "animal.db";

  String colName = "name";
  String colImage = "image";
  String colLocation = "location";
  String colCommonName = "commonName";
  String colHeight = "height";
  String colWeight = "weight";
  String colTopSpeed = "topSpeed";
  String colMostDistinctiveFeature = "mostDistinctiveFeature";

  Database? db;
  List<String> animalName = [
    "elephant.jpg",
    "weekly.jpg",
    "monthly.jpg",
    "tiger.jpg",
    "wild_animals.jpeg",
  ];

  Future<Database> initDB() async {
    var db = await openDatabase(dbName);
    String path = await getDatabasesPath();
    String pathJoin = join(path, dbName);

    String query =
        "CREATE TABLE IF NOT EXISTS $tableName($colName TEXT,$colLocation TEXT,$colCommonName TEXT,$colTopSpeed TEXT,$colMostDistinctiveFeature TEXT,$colHeight TEXT,$colWeight TEXT,$colImage BLOB);";
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(query);
    });
    return db;
  }

  insertDB({
    required List<WildAnimal?> wildAnimalData,
    required List<String> image,
  }) async {
    await initDB();
    int res = 0;
    for (int i = 0; i < animalName.length; i++) {
      wildAnimalData
          .add(await SplashHelper.splashHelper.splashImage() as WildAnimal?);

      for (int i = 0; i < wildAnimalData.length; i++) {
        String query =
            "INSERT INTO $tableName($colName,$colMostDistinctiveFeature,$colTopSpeed,$colCommonName,$colLocation,$colHeight,$colWeight,$colImage) VALUES (?,?,?,?,?,?,?,?);";
        List args = [
          wildAnimalData[i]!.name,
          // wildAnimalData[i]!.images,
          wildAnimalData[i]!.description,
          wildAnimalData[i]!.category,
          wildAnimalData[i]!.price,
          wildAnimalData[i]!.image,
        ];
        res = await db!.rawInsert(query, args);
        return res;
      }
    }
  }

  Future<List<WildAnimal>> fetchAllResponse() async {
    await initDB();
    db = await initDB();
    String query = "SELECT * FROM $tableName";
    List<Map<String, dynamic>> response = await db!.rawQuery(query);
    List<WildAnimal> wildAnimalData =
        response.map((e) => WildAnimal.fromJson(jsonData: e)).toList();
    return wildAnimalData;
  }

  Future<List<WildAnimal>> searchData({required String val}) async {
    db = await initDB();

    String query = "SELECT * FROM $tableName WHERE $colName LIKE '%$val%';";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<WildAnimal> searchedAnimalData = res
        .map(
          (e) => WildAnimal.fromJson(jsonData: e),
        )
        .toList();

    return searchedAnimalData;
  }

  Future<int> deleteAllData() async {
    db = await initDB();

    String query = "DELETE FROM $tableName";

    return await db!.rawDelete(query);
  }
}
