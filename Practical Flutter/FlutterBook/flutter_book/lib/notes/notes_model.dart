import "../base_model.dart";

class Note {
  int id;
  String title;
  String content;
  String color;

  Note({this.id = -1, this.title = "", this.content = "", this.color = ""});

  @override
  String toString() {
    return "{ id=$id, title=$title, content=$content, color=$color }";
  }
}

class NotesModel extends BaseModel {
  String color = "grey";

  void setColor(String inColor) {
    print("## NotesModel.setColor(): inColor = $inColor");

    color = inColor;
    notifyListeners();
  }
}

NotesModel notesModel = NotesModel();
