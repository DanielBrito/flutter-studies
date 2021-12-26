import "../base_model.dart";

class Contact {
  int id;
  String name;
  String phone;
  String email;
  String birthday; // YYYY,MM,DD

  Contact(
      {this.id = -1,
      this.name = "",
      this.phone = "",
      this.email = "",
      this.birthday = ""});

  @override
  String toString() {
    return "{ id=$id, name=$name, phone=$phone, email=$email, birthday=$birthday }";
  }
}

class ContactsModel extends BaseModel {
  void triggerRebuild() {
    print("## ContactsModel.triggerRebuild()");

    notifyListeners();
  }
}

ContactsModel contactsModel = ContactsModel();
