import "../base_model.dart";

class Note {
  int id = -1;
  String title = "";
  String content = "";
  String color = "";

  @override
  String toString() {
    return "{ id=$id, title=$title, content=$content, color=$color }";
  }
}

class NotesModel extends BaseModel {
  String color = "gray";

  void setColor(String inColor) {
    print("## NotesModel.setColor(): inColor = $inColor");

    color = inColor;
    notifyListeners();
  }
}

NotesModel notesModel = NotesModel();
