import 'dart:io';
import 'package:login/src/models/User.dart';
import "package:path/path.dart";
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final _name = "PATM";
  final _version = 1;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    // Ubicamos donde se va a almacenar la base de datos
    Directory folder = await getApplicationDocumentsDirectory();

    // Creamos la ruta
    String path = join(folder.path, _name);

    return await openDatabase(path, version: _version, onCreate: _createTables);
  }

  _createTables(Database db, int version) async {
    await db.execute(
        "CREATE TABLE tbl_profile(idUser INTEGER PRIMARY KEY, name varchar(25), lastName varchar(25), phone varchar(10), email varchar(30), photo varchar(250), username varchar(30), password varchar(20))");
  }

  Future<int> insert(Map<String, dynamic> row, String table) async {
    // Traemos la base de datos
    var dbClient = await database;

    // Regresamos la cantidad de registros afectados
    return await dbClient.insert(table, row);
  }

  Future<int> update(Map<String, dynamic> row, String table) async {
    // Traemos la base de datos
    var dbClient = await database;

    // Regresamos la cantidad de registros afectados
    return await dbClient
        .update(table, row, where: "id = ?", whereArgs: [row["id"]]);
  }

  Future<int> delete(int id, String table) async {
    // Traemos la base de datos
    var dbClient = await database;

    // Regresamos la cantidad de registros afectados
    return await dbClient.delete(table, where: "id = ?", whereArgs: [id]);
  }

  Future<User> getUser(String email) async {
    var dbClient = await database;

    var result = await dbClient
        .query("tbl_profile", where: "email = ?", whereArgs: [email]);

    var list = (result).map((e) => User.fromJSON(e)).toList();
    return list.length > 0
        ? list[0]
        : null;
  }
}
