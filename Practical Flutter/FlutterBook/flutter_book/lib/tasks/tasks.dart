import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "tasks_db_worker.dart";
import "tasks_list.dart";
import "tasks_entry.dart";
import "tasks_model.dart" show TasksModel, tasksModel;

class Tasks extends StatelessWidget {
  Tasks({Key? key}) : super(key: key) {
    print("## Tasks.constructor");

    // Initial load of data.
    tasksModel.loadData("tasks", TasksDBWorker.db);
  }

  @override
  Widget build(BuildContext context) {
    print("## Tasks.build()");

    return ScopedModel<TasksModel>(
      model: tasksModel,
      child: ScopedModelDescendant<TasksModel>(
        builder: (context, child, model) {
          return IndexedStack(
            index: model.stackIndex,
            children: [const TasksList(), TasksEntry()],
          );
        },
      ),
    );
  }
}
