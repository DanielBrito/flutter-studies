import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "notes_db_worker.dart";
import "notes_list.dart";
import "notes_entry.dart";
import "notes_model.dart" show NotesModel, notesModel;

class Notes extends StatelessWidget {
  Notes({Key? key}) : super(key: key) {
    print("## Notes.constructor");

    notesModel.loadData("notes", NotesDBWorker.db);
  }

  @override
  Widget build(BuildContext context) {
    print("## Notes.build()");

    return ScopedModel<NotesModel>(
      model: notesModel,
      child: ScopedModelDescendant<NotesModel>(
        builder: (context, child, model) {
          return IndexedStack(
            index: model.stackIndex,
            children: [
              const NotesList(),
              NotesEntry(),
            ],
          );
        },
      ),
    );
  }
}
