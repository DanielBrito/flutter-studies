import "dart:async";
import "dart:io";
import "package:flutter/material.dart";
import "package:path/path.dart";
import "package:scoped_model/scoped_model.dart";
import "package:image_picker/image_picker.dart";

import "../utils.dart" as utils;
import "contacts_db_worker.dart";
import "contacts_model.dart" show ContactsModel, contactsModel;

class ContactsEntry extends StatelessWidget {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ContactsEntry({Key? key}) : super(key: key) {
    print("## ContactsEntry.constructor");

    _nameEditingController.addListener(() {
      contactsModel.entityBeingEdited.name = _nameEditingController.text;
    });

    _phoneEditingController.addListener(() {
      contactsModel.entityBeingEdited.phone = _phoneEditingController.text;
    });

    _emailEditingController.addListener(() {
      contactsModel.entityBeingEdited.email = _emailEditingController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("## ContactsEntry.build()");

    if (contactsModel.entityBeingEdited != null) {
      _nameEditingController.text = contactsModel.entityBeingEdited.name;
      _phoneEditingController.text = contactsModel.entityBeingEdited.phone;
      _emailEditingController.text = contactsModel.entityBeingEdited.email;
    }

    File avatarFile;

    return ScopedModel(
      model: contactsModel,
      child: ScopedModelDescendant<ContactsModel>(
        builder: (context, child, model) {
          // Get reference to avatar file, if any.  If it doesn't exist and the
          // entityBeingEdited has an id then look for an avatar file for
          // the existing contact.
          avatarFile = File(join(utils.docsDir.path, "avatar"));

          if (avatarFile.existsSync() == false) {
            print("## avatarFile.existsSync() == false");

            if (model.entityBeingEdited != null &&
                model.entityBeingEdited.id != -1) {
              print("## Edit avatar file");

              avatarFile = File(join(
                  utils.docsDir.path, model.entityBeingEdited.id.toString()));
            }
          }

          return Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Row(
                children: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      // Delete avatar file if it exists (it shouldn't, but better safe than sorry!)
                      File avatarFile =
                          File(join(utils.docsDir.path, "avatar"));

                      if (avatarFile.existsSync()) {
                        avatarFile.deleteSync();
                      }

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
                      _save(context, model);
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
                    title: avatarFile.existsSync()
                        ? SizedBox(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(avatarFile),
                            ),
                          )
                        : const Text("No avatar image for this contact"),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.blue,
                      onPressed: () => _selectAvatar(context),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: TextFormField(
                      decoration: const InputDecoration(hintText: "Name"),
                      controller: _nameEditingController,
                      validator: (String? inValue) {
                        if (inValue!.isEmpty) {
                          return "Please enter a name";
                        }
                        return null;
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(hintText: "Phone"),
                      controller: _phoneEditingController,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: "Email"),
                      controller: _emailEditingController,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.today),
                    title: const Text("Birthday"),
                    subtitle: Text(contactsModel.chosenDate == ""
                        ? ""
                        : contactsModel.chosenDate),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.blue,
                      onPressed: () async {
                        // Request a date from the user.  If one is returned, store it.
                        String chosenDate = await utils.selectDate(
                            context,
                            contactsModel,
                            contactsModel.entityBeingEdited.birthday);

                        if (chosenDate != "") {
                          contactsModel.entityBeingEdited.birthday = chosenDate;
                        }
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

  // Function for handling taps on the edit icon for avatar.
  Future _selectAvatar(BuildContext context) {
    print("## ContactsEntry._selectAvatar()");

    var picker = ImagePicker();
    XFile? image;

    return showDialog(
      context: context,
      builder: (BuildContext inDialogContext) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text("Take a picture"),
                  onTap: () async {
                    image = await picker.pickImage(source: ImageSource.camera);

                    if (image != null) {
                      File file = File(image!.path);

                      print("## IMAGE PATH: ${image!.name}");

                      file.copySync(join(utils.docsDir.path, "avatar"));

                      contactsModel.triggerRebuild();
                    }

                    Navigator.of(inDialogContext).pop();
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                GestureDetector(
                  child: const Text("Select From Gallery"),
                  onTap: () async {
                    image = await picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      File file = File(image!.path);
                      file.copySync(join(utils.docsDir.path, "avatar"));

                      contactsModel.triggerRebuild();
                    }

                    Navigator.of(inDialogContext).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _save(BuildContext context, ContactsModel inModel) async {
    print("## ContactsEntry._save()");

    // Abort if form isn't valid.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // We'll need the ID whether creating or updating way.
    int id = -1;

    if (inModel.entityBeingEdited.id == -1) {
      print("## ContactsEntry._save(): Creating: ${inModel.entityBeingEdited}");

      id = await ContactsDBWorker.db.create(contactsModel.entityBeingEdited);
    } else {
      print("## ContactsEntry._save(): Updating: ${inModel.entityBeingEdited}");

      id = contactsModel.entityBeingEdited.id;

      await ContactsDBWorker.db.update(contactsModel.entityBeingEdited);
    }

    // If there is an avatar file, rename it using the ID.
    File avatarFile = File(join(utils.docsDir.path, "avatar"));

    if (avatarFile.existsSync()) {
      print("## ContactsEntry._save(): Renaming avatar file to id = $id");

      avatarFile.renameSync(join(utils.docsDir.path, id.toString()));
    }

    contactsModel.loadData("contacts", ContactsDBWorker.db);

    inModel.setStackIndex(0);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Contact saved"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
