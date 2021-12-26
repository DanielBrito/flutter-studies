import "dart:io";
import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:intl/intl.dart";
import "package:path/path.dart";

import "../utils.dart" as utils;
import "contacts_db_worker.dart";
import "contacts_model.dart" show Contact, ContactsModel, contactsModel;

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("## ContactsList.build()");

    return ScopedModel<ContactsModel>(
      model: contactsModel,
      child: ScopedModelDescendant<ContactsModel>(
        builder: (context, child, model) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () async {
                // Delete avatar file if it exists (it shouldn't, but better safe than sorry!)
                File avatarFile = File(join(utils.docsDir.path, "avatar"));

                if (avatarFile.existsSync()) {
                  avatarFile.deleteSync();
                }

                contactsModel.entityBeingEdited = Contact();
                contactsModel.setChosenDate("");
                contactsModel.setStackIndex(1);
              },
            ),
            body: ListView.builder(
              itemCount: contactsModel.entityList.length,
              itemBuilder: (BuildContext inBuildContext, int inIndex) {
                Contact contact = contactsModel.entityList[inIndex];

                // Get reference to avatar file and see if it exists.
                File avatarFile =
                    File(join(utils.docsDir.path, contact.id.toString()));

                bool avatarFileExists = avatarFile.existsSync();

                print(
                    "## ContactsList.build(): avatarFile: $avatarFile -- avatarFileExists=$avatarFileExists");

                return Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      Slidable(
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
                                      title: const Text("Delete Contact"),
                                      content: Text(
                                          "Are you sure you want to delete ${contact.name}?"),
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
                                            await ContactsDBWorker.db
                                                .delete(contact.id);

                                            Navigator.of(inAlertContext).pop();

                                            ScaffoldMessenger.of(inAlertContext)
                                                .showSnackBar(
                                              const SnackBar(
                                                duration: Duration(seconds: 2),
                                                content:
                                                    Text("Contact deleted"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );

                                            // Reload data from database to update list.
                                            contactsModel.loadData("contacts",
                                                ContactsDBWorker.db);
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
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigoAccent,
                            foregroundColor: Colors.white,
                            backgroundImage:
                                avatarFileExists ? FileImage(avatarFile) : null,
                            child: avatarFileExists
                                ? null
                                : Text(
                                    contact.name.substring(0, 1).toUpperCase(),
                                  ),
                          ),
                          title: Text(contact.name),
                          subtitle: contact.phone == ""
                              ? const Text("")
                              : Text(contact.phone),
                          onTap: () async {
                            // Delete avatar file if it exists (it shouldn't, but better safe than sorry!)
                            File avatarFile =
                                File(join(utils.docsDir.path, "avatar"));

                            if (avatarFile.existsSync()) {
                              avatarFile.deleteSync();
                            }

                            contactsModel.entityBeingEdited =
                                await ContactsDBWorker.db.get(contact.id);

                            // Parse out the  birthday, if any, and set it in the model for display.
                            if (contactsModel.entityBeingEdited.birthday ==
                                "") {
                              contactsModel.setChosenDate("");
                            } else {
                              List dateParts = contactsModel
                                  .entityBeingEdited.birthday
                                  .split(",");

                              DateTime birthday = DateTime(
                                int.parse(dateParts[0]),
                                int.parse(dateParts[1]),
                                int.parse(dateParts[2]),
                              );

                              contactsModel.setChosenDate(
                                DateFormat.yMMMMd("en_US")
                                    .format(birthday.toLocal()),
                              );
                            }

                            contactsModel.setStackIndex(1);
                          },
                        ),
                      ),
                      const Divider()
                    ],
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
