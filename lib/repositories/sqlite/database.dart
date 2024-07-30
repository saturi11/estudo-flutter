import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

Map<int, String> scripts = {
  1: ''' CREATE TABLE tarefas(
         id integer primary key autoincrement,
         descricao text,
         concluido integer
   );'''
};

class DatabaseHelper {
  static Database? db;

  Future<void> addConcluidoColumn() async {
    var db = await DatabaseHelper().obterDatabase();
    var tableInfo = await db.rawQuery('PRAGMA table_info(tarefas)');
    var columnExists = tableInfo.any((column) => column['name'] == 'concluido');

    if (!columnExists) {
      await db.execute(
          'ALTER TABLE tarefas ADD COLUMN concluido INTEGER DEFAULT 0');
    }
  }

  Future<Database> obterDatabase() async {
    if (db == null) {
      return await initBanco();
    }
    return db!;
  }

  Future<Database> initBanco() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: scripts.length, onCreate: (db, version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        debugPrint(scripts[i]!);
      }
    }, onUpgrade: (db, oldVersion, newVersion) async {
      for (var i = oldVersion + 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
        debugPrint(scripts[i]!);
      }
    });
    return db;
  }
}
