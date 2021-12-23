import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "../utils.dart" as utils;
import "tasks_db_worker.dart";
import "tasks_model.dart" show TasksModel, tasksModel;

class TasksEntry extends StatelessWidget {
  final TextEditingController _descriptionEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TasksEntry({Key? key}) : super(key: key) {
    print("## TasksList.constructor");

    _descriptionEditingController.addListener(() {
      tasksModel.entityBeingEdited.description =
          _descriptionEditingController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("## TasksEntry.build()");

    // Set value of controllers.
    if (tasksModel.entityBeingEdited != null) {
      _descriptionEditingController.text =
          tasksModel.entityBeingEdited.description;
    }

    return ScopedModel(
      model: tasksModel,
      child: ScopedModelDescendant<TasksModel>(
        builder: (context, child, model) {
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Row(
                children: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      // Hide soft keyboard.
                      FocusScope.of(context).requestFocus(FocusNode());
                      // Go back to the list view.
                      model.setStackIndex(0);
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    child: const Text("Save"),
                    onPressed: () {
                      _save(context, tasksModel);
                    },
                  ),
                ],
              ),
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // Description.
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration:
                          const InputDecoration(hintText: "Description"),
                      controller: _descriptionEditingController,
                      validator: (String? inValue) {
                        if (inValue!.isEmpty) {
                          return "Please enter a description";
                        }
                        return null;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.today),
                    title: const Text("Due Date"),
                    subtitle: Text(tasksModel.chosenDate),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.blue,
                      onPressed: () async {
                        // Request a date from the user.  If one is returned, store it.
                        String chosenDate = await utils.selectDate(context,
                            tasksModel, tasksModel.entityBeingEdited.dueDate);

                        tasksModel.entityBeingEdited.dueDate = chosenDate;
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Save this task to the database.
  void _save(BuildContext context, TasksModel inModel) async {
    print("## TasksEntry._save()");

    // Abort if form isn't valid.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Creating a new task.
    if (inModel.entityBeingEdited.id == -1) {
      print("## TasksEntry._save(): Creating: ${inModel.entityBeingEdited}");

      await TasksDBWorker.db.create(tasksModel.entityBeingEdited);
    } else {
      // Updating an existing task.
      print("## TasksEntry._save(): Updating: ${inModel.entityBeingEdited}");

      await TasksDBWorker.db.update(tasksModel.entityBeingEdited);
    }

    // Reload data from database to update list.
    tasksModel.loadData("tasks", TasksDBWorker.db);

    // Go back to the list view.
    inModel.setStackIndex(0);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Task saved"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
