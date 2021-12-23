import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

import "../utils.dart" as utils;
import "tasks_model.dart";

class TasksDBWorker {
  static final TasksDBWorker db = TasksDBWorker._();

  TasksDBWorker._();

  // Singleton instance:
  static Database? _database;

  Future<Database> get database async => _database ??= await init();

  Future<Database> init() async {
    print("## Tasks TasksDBWorker.init()");

    String path = join(utils.docsDir.path, "tasks.db");

    print("## tasks TasksDBWorker.init(): path = $path");

    Database db = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database inDB, int inVersion) async {
        await inDB.execute("CREATE TABLE IF NOT EXISTS tasks ("
            "id INTEGER PRIMARY KEY,"
            "description TEXT,"
            "dueDate TEXT,"
            "completed TEXT"
            ")");
      },
    );

    return db;
  }

  Task taskFromMap(Map inMap) {
    print("## Tasks TasksDBWorker.taskFromMap(): inMap = $inMap");

    Task task = Task();

    task.id = inMap["id"];
    task.description = inMap["description"];
    task.dueDate = inMap["dueDate"];
    task.completed = inMap["completed"];

    print("## Tasks TasksDBWorker.taskFromMap(): task = $task");

    return task;
  }

  Map<String, dynamic> taskToMap(Task inTask) {
    print("## Tasks TasksDBWorker.taskToMap(): inTask = $inTask");

    Map<String, dynamic> map = <String, dynamic>{};

    map["id"] = inTask.id;
    map["description"] = inTask.description;
    map["dueDate"] = inTask.dueDate;
    map["completed"] = inTask.completed;

    print("## Tasks TasksDBWorker.taskToMap(): map = $map");

    return map;
  }

  Future create(Task inTask) async {
    print("## Tasks TasksDBWorker.create(): inTask = $inTask");

    Database db = await database;

    // Get largest current id in the table, plus one, to be the new ID.
    dynamic val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM tasks");

    int? id = val.first["id"];
    id ??= 1;

    return await db.rawInsert(
      "INSERT INTO tasks (id, description, dueDate, completed) VALUES (?, ?, ?, ?)",
      [id, inTask.description, inTask.dueDate, inTask.completed],
    );
  }

  Future<Task> get(int inID) async {
    print("## Tasks TasksDBWorker.get(): inID = $inID");

    Database db = await database;

    var rec = await db.query(
      "tasks",
      where: "id = ?",
      whereArgs: [inID],
    );

    print("## Tasks TasksDBWorker.get(): rec.first = $rec.first");

    return taskFromMap(rec.first);
  }

  Future<List> getAll() async {
    print("## Tasks TasksDBWorker.getAll()");

    Database db = await database;

    var recs = await db.query("tasks");
    var list = recs.isNotEmpty ? recs.map((m) => taskFromMap(m)).toList() : [];

    print("## Tasks TasksDBWorker.getAll(): list = $list");

    return list;
  }

  Future update(Task inTask) async {
    print("## Tasks TasksDBWorker.update(): inTask = $inTask");

    Database db = await database;

    return await db.update(
      "tasks",
      taskToMap(inTask),
      where: "id = ?",
      whereArgs: [inTask.id],
    );
  }

  Future delete(int inID) async {
    print("## Tasks TasksDBWorker.delete(): inID = $inID");

    Database db = await database;

    return await db.delete(
      "Tasks",
      where: "id = ?",
      whereArgs: [inID],
    );
  }
}
