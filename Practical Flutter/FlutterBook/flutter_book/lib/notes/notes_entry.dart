import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "notes_db_worker.dart";
import "notes_model.dart" show NotesModel, notesModel;

class NotesEntry extends StatelessWidget {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _contentEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  NotesEntry({Key? key}) : super(key: key) {
    print("## NotesEntry.constructor");

    _titleEditingController.addListener(() {
      notesModel.entityBeingEdited.title = _titleEditingController.text;
    });

    _contentEditingController.addListener(() {
      notesModel.entityBeingEdited.content = _contentEditingController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("## NotesEntry.build()");

    if (notesModel.entityBeingEdited != null) {
      _titleEditingController.text = notesModel.entityBeingEdited.title;
      _contentEditingController.text = notesModel.entityBeingEdited.content;
    }

    return ScopedModel(
      model: notesModel,
      child: ScopedModelDescendant<NotesModel>(
        builder: (context, inChild, inModel) {
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
                      inModel.setStackIndex(0);
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    child: const Text("Save"),
                    onPressed: () {
                      _save(context, notesModel);
                    },
                  ),
                ],
              ),
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.title),
                    title: TextFormField(
                      decoration: const InputDecoration(hintText: "Title"),
                      controller: _titleEditingController,
                      validator: (String? inValue) {
                        if (inValue!.isEmpty) {
                          return "Please enter a title";
                        }
                        return null;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.content_paste),
                    title: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration: const InputDecoration(hintText: "Content"),
                      controller: _contentEditingController,
                      validator: (String? inValue) {
                        if (inValue!.isEmpty) {
                          return "Please enter a content";
                        }
                        return null;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.color_lens),
                    title: Row(
                      children: [
                        GestureDetector(
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: Border.all(
                                      color: Colors.red.shade100, width: 15) +
                                  Border.all(
                                      width: 6,
                                      color: notesModel.color == "red"
                                          ? Colors.red.shade100
                                          : Theme.of(context).canvasColor),
                            ),
                          ),
                          onTap: () {
                            notesModel.entityBeingEdited.color = "red";
                            notesModel.setColor("red");
                          },
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: Border.all(
                                      color: Colors.lightGreen.shade100,
                                      width: 15) +
                                  Border.all(
                                      width: 6,
                                      color: notesModel.color == "green"
                                          ? Colors.lightGreen.shade100
                                          : Theme.of(context).canvasColor),
                            ),
                          ),
                          onTap: () {
                            notesModel.entityBeingEdited.color = "green";
                            notesModel.setColor("green");
                          },
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: Border.all(
                                      color: Colors.lightBlue.shade100,
                                      width: 15) +
                                  Border.all(
                                      width: 6,
                                      color: notesModel.color == "blue"
                                          ? Colors.lightBlue.shade100
                                          : Theme.of(context).canvasColor),
                            ),
                          ),
                          onTap: () {
                            notesModel.entityBeingEdited.color = "blue";
                            notesModel.setColor("blue");
                          },
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: Border.all(
                                      color: Colors.yellow.shade100,
                                      width: 15) +
                                  Border.all(
                                      width: 6,
                                      color: notesModel.color == "yellow"
                                          ? Colors.yellow.shade100
                                          : Theme.of(context).canvasColor),
                            ),
                          ),
                          onTap: () {
                            notesModel.entityBeingEdited.color = "yellow";
                            notesModel.setColor("yellow");
                          },
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: Border.all(
                                      color: Colors.brown.shade100, width: 15) +
                                  Border.all(
                                      width: 6,
                                      color: notesModel.color == "brown"
                                          ? Colors.brown.shade100
                                          : Theme.of(context).canvasColor),
                            ),
                          ),
                          onTap: () {
                            notesModel.entityBeingEdited.color = "brown";
                            notesModel.setColor("brown");
                          },
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: Border.all(
                                      color: Colors.deepPurple.shade100,
                                      width: 15) +
                                  Border.all(
                                      width: 6,
                                      color: notesModel.color == "purple"
                                          ? Colors.deepPurple.shade100
                                          : Theme.of(context).canvasColor),
                            ),
                          ),
                          onTap: () {
                            notesModel.entityBeingEdited.color = "purple";
                            notesModel.setColor("purple");
                          },
                        ),
                      ],
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

  // Save this contact to the database.
  void _save(BuildContext context, NotesModel inModel) async {
    print("## NotesEntry._save()");

    // Abort if form isn't valid.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Creating a new note.
    if (inModel.entityBeingEdited.id == -1) {
      print("## NotesEntry._save(): Creating: ${inModel.entityBeingEdited}");

      await NotesDBWorker.db.create(notesModel.entityBeingEdited);
    } else {
      // Updating an existing note.
      print("## NotesEntry._save(): Updating: ${inModel.entityBeingEdited}");

      await NotesDBWorker.db.update(notesModel.entityBeingEdited);
    }

    // Reload data from database to update list.
    notesModel.loadData("notes", NotesDBWorker.db);

    // Go back to the list view.
    inModel.setStackIndex(0);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Note saved"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
