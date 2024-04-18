import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:todo_app/Model/Task.dart';

class DatabaseHandler{


static Database? _database;

Future<Database>get database async=> _database??= await initDatabase();
Future<Database> initDatabase() async {
  final path = join(await getDatabasesPath(), 'todo.db');
  _database = await openDatabase(path, version: 1, onCreate: _createDatabase);
  return _database!;
}

Future<void> _createDatabase(Database db, int version) async {
  await db.execute('''
      CREATE TABLE Tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        startTime TEXT,
        endTime TEXT,
        type TEXT,
        isImportant TEXT,
        status TEXT,
        date TEXT
      )
    ''');
  }

Future<List<Task>> getTask() async {
  final db = await database;
  final List<Map<String, dynamic>> rows = await db.query('Tasks');
  List<Task> taskList = rows
      .map((e) => Task(
      status: e["status"],
      type: e["type"],
      title: e["title"],
      date: e["date"],
      endTime: e["endTime"],
      isImportant: e["isImportant"],
      id: e["id"],
      startTime: e["startTime"]))
      .toList();
  return taskList;
}

/*Future<int> getImportantTaskCount() async {
  final db = await database;
  final List<Map<String, dynamic>> rows = await db.query('Tasks');
  List<Task> taskList = rows
      .map((e) => Task(
      status: e["status"],
      type: e["type"],
      title: e["title"],
      date: e["date"],
      endTime: e["endTime"],
      isImportant: e["isImportant"],
      id: e["id"],
      startTime: e["startTime"]))
      .toList();
  int count=0;
  for(int i=0;i<taskList.length;i++){
    if(taskList[i].isImportant=="1"){
      count++;
    }
  }
  return count;
}


Future<int> getPersonalTaskCount() async {
  final db = await database;
  final List<Map<String, dynamic>> rows = await db.query('Tasks');
  List<Task> taskList = rows
      .map((e) => Task(
      status: e["status"],
      type: e["type"],
      title: e["title"],
      date: e["date"],
      endTime: e["endTime"],
      isImportant: e["isImportant"],
      id: e["id"],
      startTime: e["startTime"]))
      .toList();
  int count=0;
  for(int i=0;i<taskList.length;i++){
    if(taskList[i].type=="Personal"){
      count++;
    }
  }
  return count;
}

Future<int> getLearningTaskCount() async {
  final db = await database;
  final List<Map<String, dynamic>> rows = await db.query('Tasks');
  List<Task> taskList = rows
      .map((e) => Task(
      status: e["status"],
      type: e["type"],
      title: e["title"],
      date: e["date"],
      endTime: e["endTime"],
      isImportant: e["isImportant"],
      id: e["id"],
      startTime: e["startTime"]))
      .toList();
  int count=0;
  for(int i=0;i<taskList.length;i++){
    if(taskList[i].type=="Learning"){
      count++;
    }
  }
  return count;
}


Future<int> getShoppingTaskCount() async {
  final db = await database;
  final List<Map<String, dynamic>> rows = await db.query('Tasks');
  List<Task> taskList = rows
      .map((e) => Task(
      status: e["status"],
      type: e["type"],
      title: e["title"],
      date: e["date"],
      endTime: e["endTime"],
      isImportant: e["isImportant"],
      id: e["id"],
      startTime: e["startTime"]))
      .toList();
  int count=0;
  for(int i=0;i<taskList.length;i++){
    if(taskList[i].type=="Shopping"){
      count++;
    }
  }
  return count;
}

Future<int> getWorkTaskCount() async {
  final db = await database;
  final List<Map<String, dynamic>> rows = await db.query('Tasks');
  List<Task> taskList = rows
      .map((e) => Task(
      status: e["status"],
      type: e["type"],
      title: e["title"],
      date: e["date"],
      endTime: e["endTime"],
      isImportant: e["isImportant"],
      id: e["id"],
      startTime: e["startTime"]))
      .toList();
  int count=0;
  for(int i=0;i<taskList.length;i++){
    if(taskList[i].type=="Work"){
      count++;
    }
  }
  return count;
}*/

Future<int> deleteTask(int id) async {
  final db = await database;
  int rowId = await db.delete(
    'Tasks',
    where: 'id = $id',
  );
  return rowId;
}


Future<int> addTask(Task task) async {
  final db = await database;
  int rowId = await db.insert('Tasks', task.toMap());
  return rowId;
}

}

/*

Future<List<Vehicle>> getVehicles() async {
    final db = await database;
    final List<Map<String, dynamic>> rows = await db.query('vehicles');
    List<Vehicle> vehicleList = rows
        .map((e) => Vehicle(id: e['id'], name: e['name'], model: e['model']))
        .toList();
    return vehicleList;
  }

  Future<int> insertVehicle(Vehicle vehicle) async {
    final db = await database;
    int rowId = await db.insert('vehicles', vehicle.toMap());
    return rowId;
  }

  Future<int> deleteVehicle(String name) async {
    final db = await database;
    int rowId = await db.delete(
      'vehicles',
      where: 'name = $name',
      whereArgs: [name],
    );
    return rowId;
  }

 */