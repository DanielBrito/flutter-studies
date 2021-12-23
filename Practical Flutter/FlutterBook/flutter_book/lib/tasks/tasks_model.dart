import "../base_model.dart";

class Task {
  int id;
  String description;
  String dueDate; // YYYY,MM,DD
  String completed;

  Task(
      {this.id = -1,
      this.description = "",
      this.dueDate = "",
      this.completed = "false"});

  @override
  String toString() {
    return "{ id=$id, description=$description, dueDate=$dueDate, completed=$completed }";
  }
}

class TasksModel extends BaseModel {}

TasksModel tasksModel = TasksModel();
