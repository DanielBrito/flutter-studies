import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "package:flutter_slidable/flutter_slidable.dart";

import "package:intl/intl.dart";
import "tasks_db_worker.dart";
import "tasks_model.dart" show Task, TasksModel, tasksModel;

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("## TasksList.build()");

    return ScopedModel<TasksModel>(
      model: tasksModel,
      child: ScopedModelDescendant<TasksModel>(
        builder: (context, child, model) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () async {
                tasksModel.entityBeingEdited = Task();
                tasksModel.setChosenDate("");
                tasksModel.setStackIndex(1);
              },
            ),
            body: ListView.builder(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              itemCount: tasksModel.entityList.length,
              itemBuilder: (BuildContext inBuildContext, int inIndex) {
                Task task = tasksModel.entityList[inIndex];

                String sDueDate = "";

                if (task.dueDate != "") {
                  List dateParts = task.dueDate.split(",");

                  DateTime dueDate = DateTime(int.parse(dateParts[0]),
                      int.parse(dateParts[1]), int.parse(dateParts[2]));

                  sDueDate =
                      DateFormat.yMMMMd("en_US").format(dueDate.toLocal());
                }

                return Container(
                  padding: inIndex == tasksModel.entityList.length - 1
                      ? const EdgeInsets.all(20)
                      : const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: .25,
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext contextLocal) async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext inAlertContext) {
                                return AlertDialog(
                                  title: const Text("Delete Task"),
                                  content: Text(
                                      "Are you sure you want to delete ${task.description}?"),
                                  actions: [
                                    TextButton(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        // Just hide dialog.
                                        Navigator.of(inAlertContext).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Delete"),
                                      onPressed: () async {
                                        await TasksDBWorker.db.delete(task.id);

                                        Navigator.of(inAlertContext).pop();

                                        ScaffoldMessenger.of(inAlertContext)
                                            .showSnackBar(
                                          const SnackBar(
                                            duration: Duration(seconds: 2),
                                            content: Text("Task deleted"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );

                                        // Reload data from database to update list.
                                        tasksModel.loadData(
                                            "notes", TasksDBWorker.db);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: "Delete",
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: task.completed == "true" ? true : false,
                        onChanged: (inValue) async {
                          // Update the completed value for this task and refresh the list.
                          task.completed = inValue.toString();

                          await TasksDBWorker.db.update(task);

                          tasksModel.loadData("tasks", TasksDBWorker.db);
                        },
                      ),
                      title: Text(
                        task.description,
                        // Dim and strikethrough the text when the task is completed.
                        style: task.completed == "true"
                            ? TextStyle(
                                color: Theme.of(context).disabledColor,
                                decoration: TextDecoration.lineThrough)
                            : TextStyle(color: Colors.grey.shade800),
                      ),
                      subtitle: Text(
                        sDueDate,
                        // Dim and strikethrough the text when the task is completed.
                        style: task.completed == "true"
                            ? TextStyle(
                                color: Theme.of(context).disabledColor,
                                decoration: TextDecoration.lineThrough)
                            : TextStyle(color: Colors.grey.shade600),
                      ),
                      onTap: () async {
                        // Can't edit a completed task.
                        if (task.completed == "true") {
                          return;
                        }

                        // Get the data from the database and send to the edit view.
                        tasksModel.entityBeingEdited =
                            await TasksDBWorker.db.get(task.id);

                        // Parse out the due date, if any, and set it in the model for display.
                        if (tasksModel.entityBeingEdited.dueDate == null) {
                          tasksModel.setChosenDate("");
                        } else {
                          tasksModel.setChosenDate(sDueDate);
                        }

                        tasksModel.setStackIndex(1);
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void doNothing(BuildContext context) {}
}
