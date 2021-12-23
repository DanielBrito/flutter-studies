import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "package:flutter_slidable/flutter_slidable.dart";

import "notes_db_worker.dart";
import "notes_model.dart" show Note, NotesModel, notesModel;

class NotesList extends StatelessWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("## NotesList.build()");

    return ScopedModel<NotesModel>(
      model: notesModel,
      child: ScopedModelDescendant<NotesModel>(
        builder: (context, child, model) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () async {
                notesModel.entityBeingEdited = Note();
                notesModel.setColor("");
                notesModel.setStackIndex(1);
              },
            ),
            body: ListView.builder(
              itemCount: notesModel.entityList.length,
              itemBuilder: (BuildContext inBuildContext, int inIndex) {
                Note note = notesModel.entityList[inIndex];

                // Determine note background color (default to white if none was selected).
                Color color = Colors.grey.shade200;

                switch (note.color) {
                  case "red":
                    color = Colors.red.shade200;
                    break;
                  case "green":
                    color = Colors.lightGreen.shade200;
                    break;
                  case "blue":
                    color = Colors.lightBlue.shade200;
                    break;
                  case "yellow":
                    color = Colors.yellow.shade200;
                    break;
                  case "brown":
                    color = Colors.brown.shade200;
                    break;
                  case "purple":
                    color = Colors.deepPurple.shade200;
                    break;
                }

                return Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext contextLocal) async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext inAlertContext) {
                                return AlertDialog(
                                  title: const Text("Delete Note"),
                                  content: Text(
                                      "Are you sure you want to delete ${note.title}?"),
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
                                        await NotesDBWorker.db.delete(note.id);

                                        Navigator.of(inAlertContext).pop();

                                        ScaffoldMessenger.of(inAlertContext)
                                            .showSnackBar(
                                          const SnackBar(
                                            duration: Duration(seconds: 2),
                                            content: Text("Note deleted"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );

                                        // Reload data from database to update list.
                                        notesModel.loadData(
                                            "notes", NotesDBWorker.db);
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
                    child: Card(
                      elevation: 2,
                      color: color,
                      child: ListTile(
                        title: Text(note.title),
                        subtitle: Text(note.content),
                        onTap: () async {
                          // Get the data from the database and send to the edit view.
                          notesModel.entityBeingEdited =
                              await NotesDBWorker.db.get(note.id);

                          notesModel
                              .setColor(notesModel.entityBeingEdited.color);

                          notesModel.setStackIndex(1);
                        },
                      ),
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
}
