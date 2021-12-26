import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "contacts_db_worker.dart";
import "contacts_list.dart";
import "contacts_entry.dart";
import "contacts_model.dart" show ContactsModel, contactsModel;

class Contacts extends StatelessWidget {
  Contacts({Key? key}) : super(key: key) {
    print("## Contacts.constructor");

    contactsModel.loadData("contacts", ContactsDBWorker.db);
  }

  @override
  Widget build(BuildContext context) {
    print("## Contacts.build()");

    return ScopedModel<ContactsModel>(
      model: contactsModel,
      child: ScopedModelDescendant<ContactsModel>(
        builder: (context, child, model) {
          return IndexedStack(
            index: model.stackIndex,
            children: [
              const ContactsList(),
              ContactsEntry(),
            ],
          );
        },
      ),
    );
  }
}
