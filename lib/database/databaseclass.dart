import 'package:flutter/material.dart';
import 'package:lastassign/model/todotask.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Databaseclass {
  static Database? _db;
  static int getversion() => 1;
  static final String tablename = "todolist";

  static final String col1 = "id";
  static final String col2 = "taskname";
  static final String col3 = "task";
  static final String col4 = "date";

  Future<void> init() async {
    if (_db != null) {
      return;
    }
    try {
      String pathvalue = await getDatabasesPath();
      _db = await openDatabase(pathvalue + "/todo",
          version: getversion(), onCreate: oncreatecall);
      print("database created");
    } catch (e) {
      print("Error in database creation $e");
    }
  }

  Future<void> oncreatecall(Database db, int version) async {
    await db.execute("CREATE TABLE $tablename("
        "$col1 INTEGER PRIMARY KEY,"
        "$col2 TEXT,"
        "$col3 TEXT,"
        "$col4 TEXT"
        ")");
  }

  Future<int> insert(TODO taks) async {
    var value =
        await _db!.rawQuery("SELECT MAX(id)+1 AS $col1 FROM $tablename");
    var idvalue = value[0]["$col1"] ?? 1;
    idvalue = idvalue;

    print(idvalue);
    var raw = await _db!.rawInsert(
        "INSERT INTO $tablename($col1,$col2,$col3,$col4)"
        "VALUES(?,?,?,?)",
        [idvalue, taks.taskname, taks.task, taks.date]);
    return raw;
  }

  Future<List<TODO>> gettodo() async {
    var res = await _db!.query("$tablename");
    List<TODO> todolist = [];
    if (res.isNotEmpty) {
      for (int i = 0; i <= res.length - 1; i++) {
        todolist.add(TODO(
          id: res[i]['$col1'],
          task: res[i]['$col2'],
          taskname: res[i]['$col3'],
          date: res[i]['$col4'],
        ));
      }
    } else {
      print("nodata");
    }
    return todolist;
  }

  Future<void> delete(String taskname) async {
    await _db!.delete(tablename, where: '$col2=?', whereArgs: [taskname]);
    await _db!.rawQuery("DELETE FROM $tablename WHERE $col2='$taskname'");
    print("data deleted");
  }
}
