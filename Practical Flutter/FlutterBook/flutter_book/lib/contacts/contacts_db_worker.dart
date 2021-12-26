import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

import "../utils.dart" as utils;
import "contacts_model.dart";

class ContactsDBWorker {
  static final ContactsDBWorker db = ContactsDBWorker._();

  ContactsDBWorker._();

  // Singleton instance:
  static Database? _database;

  Future<Database> get database async => _database ??= await init();

  Future<Database> init() async {
    print("## Contacts ContactsDBWorker.init()");

    String path = join(utils.docsDir.path, "contacts.db");

    print("## Contacts ContactsDBWorker.init(): path = $path");

    Database db = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database inDB, int inVersion) async {
        await inDB.execute(
          "CREATE TABLE IF NOT EXISTS contacts ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "email TEXT,"
          "phone TEXT,"
          "birthday TEXT"
          ")",
        );
      },
    );

    return db;
  }

  Contact contactFromMap(Map inMap) {
    print("## Contacts ContactsDBWorker.contactFromMap(): inMap = $inMap");

    Contact contact = Contact();

    contact.id = inMap["id"];
    contact.name = inMap["name"];
    contact.phone = inMap["phone"];
    contact.email = inMap["email"];
    contact.birthday = inMap["birthday"];

    print("## Contacts ContactsDBWorker.contactFromMap(): contact = $contact");

    return contact;
  }

  Map<String, dynamic> contactToMap(Contact inContact) {
    print(
        "## Contacts ContactsDBWorker.contactToMap(): inContact = $inContact");

    Map<String, dynamic> map = <String, dynamic>{};

    map["id"] = inContact.id;
    map["name"] = inContact.name;
    map["phone"] = inContact.phone;
    map["email"] = inContact.email;
    map["birthday"] = inContact.birthday;

    print("## Contacts ContactsDBWorker.contactToMap(): map = $map");

    return map;
  }

  Future create(Contact inContact) async {
    print("## Contacts ContactsDBWorker.create(): inContact = $inContact");

    Database db = await database;

    // Get largest current id in the table, plus one, to be the new ID.
    dynamic val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM contacts");

    int? id = val.first["id"];
    id ??= 1;

    await db.rawInsert(
      "INSERT INTO contacts (id, name, email, phone, birthday) VALUES (?, ?, ?, ?, ?)",
      [
        id,
        inContact.name,
        inContact.email,
        inContact.phone,
        inContact.birthday
      ],
    );

    return id;
  }

  Future<Contact> get(int inID) async {
    print("## Contacts ContactsDBWorker.get(): inID = $inID");

    Database db = await database;

    var rec = await db.query(
      "contacts",
      where: "id = ?",
      whereArgs: [inID],
    );

    print("## Contacts ContactsDBWorker.get(): rec.first = $rec.first");

    return contactFromMap(rec.first);
  }

  Future<List> getAll() async {
    print("## Contacts ContactsDBWorker.getAll()");

    Database db = await database;

    var recs = await db.query("contacts");
    var list =
        recs.isNotEmpty ? recs.map((m) => contactFromMap(m)).toList() : [];

    print("## Contacts ContactsDBWorker.getAll(): list = $list");

    return list;
  }

  Future update(Contact inContact) async {
    print("## Contacts ContactsDBWorker.update(): inContact = $inContact");

    Database db = await database;

    return await db.update(
      "contacts",
      contactToMap(inContact),
      where: "id = ?",
      whereArgs: [inContact.id],
    );
  }

  Future delete(int inID) async {
    print("## Contacts ContactsDBWorker.delete(): inID = $inID");

    Database db = await database;

    return await db.delete(
      "contacts",
      where: "id = ?",
      whereArgs: [inID],
    );
  }
}
