import 'dart:io';

import 'package:path/path.dart';
import 'package:flutter_application_1/ClientModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
  DBProvider ._ ();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) 
      return _database;
      //If db is null
      _database = await initDB();
      return _database;
    }

    initDB() async {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, "TestDB.db");
      return await openDatabase(path, version: 1, onOpen: (db){
      }, onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE IF NOT EXISTS mesure (id INTEGER PRIMARY KEY, titre TEXT, description TEXT, image TEXT, price REAL) ");
    });
    }

    getMesures(int id) async {
      final db =  await database;
      var res = await db.query("Mesure_Table", where: "id = ?", whereArgs: [id]);
      return res.isNotEmpty ? Client.fromMap(res.first) : Null;
    }

    getAllMesures() async {
      final db =  await database;
      var res = await db.query("Mesure_Table");
      List<Client> list =
         res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
      return list;
    }

    deleteMesures(int id) async {
      final db = await database;
      db.delete("Mesure_Table", where: "id = ?", whereArgs: [id]);
    }

    deleteAllMesures() async {
      final db = await database;
      db.rawDelete("Delete * from Mesure_Table");
    }

  }

